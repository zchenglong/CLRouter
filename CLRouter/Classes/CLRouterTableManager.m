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
    [self registerRouterTableWithScheme:scheme parameters:parameters];
    return YES;
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary *)parameters {
    if (!scheme || scheme.length == 0) {
        return NO;
    }
    if (!parameters || ![parameters isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    [self.routerTables setObject:parameters forKey:scheme];
    return YES;
}

- (CLRouterTableTargetModel *)getRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host {
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
    //获取路由表项
    id target = routerTable[host];
    if (!target) {
        return nil;
    }
    if ([target isKindOfClass:[CLRouterTableTargetModel class]]) {
        return target;
    } else if ([target isKindOfClass:[NSDictionary class]]) {
        CLRouterTableTargetModel *targetModel = [[CLRouterTableTargetModel alloc]init];
        //TODO:handle targetModel
        return targetModel;
    }
    return nil;
}

@end
