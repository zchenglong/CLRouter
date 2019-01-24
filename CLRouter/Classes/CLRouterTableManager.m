//
//  CLRouterTableManager.m
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterTableManager.h"

@interface CLRouterTableManager ()

//路由表集合，以scheme作为key
@property(nonatomic, strong) NSMutableDictionary* routerTables;

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

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme filePath:(NSString *)filePath {
    if (!scheme || scheme.length == 0) {
        return NO;
    }
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    //TODO:   NSDictionary *parameters = //从文件获取数据
    NSDictionary *parameters = @{};
    if (!parameters) {
        return NO;
    }
//    [self registerRouterTableWithScheme:scheme parameters:parameters];
    [self registerRouterTableWithScheme:scheme targetConfig:[self targetConfigWithParameters:parameters]];
    return YES;
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme targetConfig:(CLRouterTargetConfig *)targetConfig {
    if (!scheme || scheme.length == 0) {
        return NO;
    }
    if (!targetConfig || ![targetConfig isKindOfClass:[CLRouterTargetConfig class]]) {
        return NO;
    }
    [self.routerTables setObject:targetConfig forKey:scheme];
    return YES;
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *, CLRouterTargetConfig *> *)parameters {
    if (!scheme || scheme.length == 0) {
        return NO;
    }
    if (!parameters || ![parameters isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:parameters forKey:@"targets"];
    [self.routerTables setObject:dictionary forKey:scheme];
    return YES;
}

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
    //获取路由表目标项的集合
    NSDictionary *targets = routerTable[@"targets"];
    if (!targets) {
        return nil;
    }
    //获取路由表目标项
    id target = targets[host];
    if (!target) {
        return nil;
    }
    
    if ([target isKindOfClass:[CLRouterTargetConfig class]]) {
        return target;
    } else if ([target isKindOfClass:[NSDictionary class]]) {
        CLRouterTargetConfig *targetConfig = [[CLRouterTargetConfig alloc]init];
        //TODO:handle targetModel
        return targetConfig;
    }
    return nil;
}

- (CLRouterTargetConfig *)targetConfigWithParameters:(NSDictionary *)parameters {
    CLRouterTargetConfig *targetConfig = [[CLRouterTargetConfig alloc]init];
    return targetConfig;
}

@end
