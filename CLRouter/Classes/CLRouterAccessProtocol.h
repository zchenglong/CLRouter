//
//  CLRouterAccessProtocol.h
//  CLRouter
//
//  Created by zcl on 2019/7/1.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"
#import "CLRouterRequest.h"
#import "CLRouterDefine.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 路由表访问协议

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

#pragma mark - 路由管理访问协议

@protocol CLRouterManagerAccessProtocol

/**
 请求路由跳转(URL)
 
 @param routerRequest 请求体，包含请求URL
 @param callback 结果回调
 */
- (void)openURLWithRouterRequest:(CLRouterURLRequest *)routerRequest callback:(RouterURLCallback)callback;

/**
 请求路由跳转（Action）
 
 @param routerRequest 请求体，包含scheme、host
 @param callback 结果回调
 */
- (void)actionWithRouterRequest:(CLRouterActionRequest *)routerRequest callback:(RouterActionCallback)callback;

@end

NS_ASSUME_NONNULL_END
