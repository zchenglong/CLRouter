//
//  CLRouterTableManager.m
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterTableManager.h"
#import "CLRouterTableHelper.h"
#import "CLRouterProtocol.h"
#import "CLRouterFileHelper.h"
#import "YYKit.h"


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

- (BOOL)isSchemeExist:(NSString *)scheme {
    if (!scheme || scheme.length == 0) {
        return NO;
    }
    if (self.routerTables[scheme]) {
        return YES;
    }
    return NO;
}

#pragma mark - CLRouterTableAccessProtocol

- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath bundle:(NSBundle *)bundle {
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    
    NSString *fileName = filePath;
    NSString *extentionType = @"json"; //default
    NSArray *filePathComponents = [filePath componentsSeparatedByString:@"."];
    if (filePathComponents.count == 2) {
        fileName = filePathComponents[0];
        extentionType = filePathComponents[1];
    }
    
    NSDictionary *parameters = [CLRouterFileHelper getDataWithFileName:fileName bundle:bundle type:extentionType]; //从文件获取数据
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


- (id)getDataWithFilePath:(NSString *)filePath bundle:(NSBundle *)bundle type:(NSString *)type {
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSString *path = [bundle pathForResource:filePath ofType:type];
    if (!path) {
        return nil;
    }
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return dicData;
}

@end
