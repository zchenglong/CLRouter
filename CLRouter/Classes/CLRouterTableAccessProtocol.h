//
//  CLRouterTableAccessProtocol.h
//  CLRouter
//
//  Created by zcl on 2019/1/15.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"

@protocol CLRouterTableAccessProtocol <NSObject>

/**
 注册路由表（文件）

 @param filePath 路由表文件路径
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath;

/**
 注册路由表（字典）
 支持多次
 @param scheme 路由协议
 @param parameters 路由配置项集合
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *, CLRouterTargetConfig *> *)parameters;

@end
