//
//  CLRouterProtocol.h
//  CLRouter
//
//  Created by zcl on 2019/1/24.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"

@protocol CLRouterProtocol <NSObject>

/**
 获取目标控制器所属模块的协议名称
 对应请求URL的scheme
 @return 路由协议名称scheme
 */
+ (NSString *)schemeForRouter;

/**
 获取目标控制器配置

 @return 目标项配置类
 */
+ (CLRouterTargetConfig *)targetConfigForRouter;

@optional

/**
 获取目标控制器的路径名称(如果未实现该协议，默认使用控制器类名)
 对应请求URL的host
 @return 路径名称host
 */
+ (NSString *)hostForRouter;

/**
 根据路由参数判断是否可以该路由(如果未实现该协议，默认YES)
 
 @param parameters 路由参数
 @return 是否可以处理路由
 */
+ (BOOL)canHandleRouterWithParameters:(NSDictionary *)parameters;

/**
 处理路由，可以对目标项做参数赋值（如果未实现该协议，默认使用KVC赋值）
 
 @param target 目标控制器对象
 @param parameters 路由参数
 */
+ (void)handleRouterWithTarget:(id)target parameters:(NSDictionary *)parameters;

/**
 支持自定义控制器跳转（如果定义为CustomType，而未实现该协议，默认Push的方式跳转）
 实现该协议可以自定义跳转方式
 @param sourceVC 源控制器
 @param destVC 目标控制器
 */
+ (void)handleCustomShowWithSourceVC:(UIViewController *)sourceVC destVC:(UIViewController *)destVC;


@end
