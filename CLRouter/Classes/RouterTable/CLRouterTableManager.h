//
//  CLRouterTableManager.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"
#import "CLRouterTableAccessProtocol.h"

@interface CLRouterTableManager : NSObject <CLRouterTableAccessProtocol>

+ (instancetype)sharedManager;

/**
 通过遍历实现Router协议的类来注册路由表
 */
- (BOOL)registerRouterTableFromClassWhichConfirmToProtocol;

/**
 添加路由表目标项配置
 
 @param scheme 路由协议名称，对应URL中的scheme
 @param host 路由目标项名称，对应URL中的host
 @param targetConfig 路由目标项配置
 @return 是否添加成功
 */
- (BOOL)addRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host targetConfig:(CLRouterTargetConfig *)targetConfig;

/**
 获取路由表目标项配置

 @param scheme 路由表名称
 @param host 路径名称
 @return 目标项配置
 */
- (CLRouterTargetConfig *)getRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host;


/**
 scheme是否在路由表中

 @param scheme 路由协议
 @return 是否在路由表中
 */
- (BOOL)isSchemeExist:(NSString *)scheme;

@end
