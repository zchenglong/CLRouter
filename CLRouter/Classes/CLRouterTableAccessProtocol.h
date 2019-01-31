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
 动态注册路由表

 @return 是否注册成功
 */
- (BOOL)registerRouterTableDynamic;

/**
 注册路由表（文件）
 
 @param filePath 路由表文件路径（支持json和plist）(例如：router_table_smart_tourism.json)
 @param bundle Bundle值，标识资源块，默认nil，指向mainBundle。
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath bundle:(NSBundle *)bundle;

/**
 注册路由表（字典）

 @param scheme 路由协议
 @param parameters 路由配置项集合
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *, CLRouterTargetConfig *> *)parameters;

@end
