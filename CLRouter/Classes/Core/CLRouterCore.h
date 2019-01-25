//
//  CLRouterCore.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"
#import "CLRouterRequest.h"

@interface CLRouterCore : NSObject


/**
 跳转目标Controller

 @param targetConfig 目标项配置
 @param parameters 目标Controller需要的参数
 @param viewController 源viewController，默认为nil，若为nil，使用当前viewController作为源
 @param callback 结果回调
 */
+ (void)gotoViewControllerWithTargetConfig:(CLRouterTargetConfig *)targetConfig parameters:(NSDictionary *)parameters sourceVC:(UIViewController *)sourceVC callback:(void (^)(BOOL success))callback;

@end
