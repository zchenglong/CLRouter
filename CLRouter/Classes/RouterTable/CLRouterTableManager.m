//
//  CLRouterTableManager.m
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterTableManager.h"
#import "YYKit.h"
#import "CLRouterTableHelper.h"
#import "CLRouterProtocol.h"


@interface CLRouterTableManager ()

//路由表集合，表结构 NSDictionary<scheme, NSDictionary<host, targetConfig>>
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, CLRouterTargetConfig *> *> *routerTables;

@end

@implementation CLRouterTableManager

+ (instancetype)sharedManager {
    static CLRouterTableManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (NSMutableDictionary *)routerTables {
    if (!_routerTables) {
        _routerTables = [NSMutableDictionary dictionary];
    }
    return _routerTables;
}

#pragma mark - PUBLIC

- (CLRouterTargetConfig *)getRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host {
    if (!scheme || scheme.length == 0) {
        return nil;
    }
    if (!host || host.length == 0) {
        return nil;
    }
    //获取路由表
    NSDictionary *routerTable = self.routerTables[scheme];
    if (!routerTable) {
        return nil;
    }
    //获取路由表目标项
    CLRouterTargetConfig *targetConfig = routerTable[host];
    if (!targetConfig) {
        return nil;
    }
    
    if ([targetConfig isKindOfClass:[CLRouterTargetConfig class]]) {
        return targetConfig;
    }
    return nil;
}

#pragma mark - CLRouterTableAccessProtocol

- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath {
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    //TODO:   NSDictionary *parameters = //从文件获取数据
    NSDictionary *parameters = @{
                                    @"scheme-tour":@{
                                         @"host1":@{
                                            @"className":@"CLViewController"
                                         },
                                         @"host2":@{
                                            @"className":@"CLViewController2"
                                         },
                                    }
                                 };
    if (!parameters) {
        return NO;
    }

    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *routerTable = obj;
        NSString *scheme = key;
        [routerTable enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *host = key;
            CLRouterTargetConfig *targetConfig = [CLRouterTargetConfig modelWithDictionary:obj];
            [self addRouterTableTargetWithScheme:scheme host:host targetConfig:targetConfig];
        }];
    }];
    return YES;
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *, CLRouterTargetConfig *> *)parameters {
    if (!parameters) {
        return NO;
    }
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *host = key;
        CLRouterTargetConfig *targetConfig = [CLRouterTargetConfig modelWithDictionary:obj];
        [self addRouterTableTargetWithScheme:scheme host:host targetConfig:targetConfig];
    }];
    return YES;
}

- (BOOL)addRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host targetConfig:(CLRouterTargetConfig *)targetConfig {
    NSMutableDictionary *originRouterTable = self.routerTables[scheme];
    if (originRouterTable) {
        [originRouterTable setObject:targetConfig forKey:host];
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:targetConfig forKey:host];
        [self.routerTables setObject:dic forKey:scheme];
    }
    return YES;
}

- (BOOL)registerRouterTableFromClassWhichConfirmToProtocol {
    NSArray *classes = [CLRouterTableHelper getClassesWhichConfirmToProtocol:@protocol(CLRouterProtocol)];
    for (Class<CLRouterProtocol> class in classes) {
        NSString *scheme = nil;
        NSString *host = nil;
        CLRouterTargetConfig *targetConfig = nil;
        
        if ([class respondsToSelector:@selector(schemeForRouter)]) {
            scheme = [class schemeForRouter];
        }
        
        if ([class respondsToSelector:@selector(hostForRouter)]) {
            host = [class hostForRouter];
        } else {
            host = NSStringFromClass(class);
        }
        
        if ([class respondsToSelector:@selector(targetConfigForRouter)]) {
            targetConfig = [class targetConfigForRouter];
        }
        
        if (scheme && host && targetConfig) {
            [self addRouterTableTargetWithScheme:scheme host:host targetConfig:targetConfig];
        }
    }
    return YES;
}

@end
