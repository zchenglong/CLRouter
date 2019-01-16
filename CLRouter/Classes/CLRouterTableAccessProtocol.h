//
//  CLRouterTableAccessProtocol.h
//  CLRouter
//
//  Created by zcl on 2019/1/15.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLRouterTableAccessProtocol <NSObject>

/**
 注册路由表（文件）
 
 @param scheme 路由表名称（需要和URL中的scheme保持一致）
 @param filePath 路由表文件路径
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithScheme:(NSString *)scheme filePath:(NSString *)filePath;

/**
 注册路由表（字典）
 如果路由表已存在，则在该路由表上增加目标项，可用于增加路由表项
 @param scheme 路由表名称（需要和URL中的scheme保持一致）
 @param parameters 路由表的字典形式(host作为键，遵循规则的NSDictionary作为值)
 @return 是否注册成功
 */
- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary *)parameters;

@end
