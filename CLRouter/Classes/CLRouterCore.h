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

 @param target 目标对象
 @param parameters 目标Controller需要的参数
 @param viewController 源viewController，默认为nil，若为nil，使用当前viewController作为源
 @param block 结果回调
 */
+ (void)gotoViewControllerWithTarget:(CLRouterTargetConfig *)target parameters:(NSDictionary *)parameters viewController:(UIViewController *)viewController callback:(void (^)(BOOL success))block;

@end
