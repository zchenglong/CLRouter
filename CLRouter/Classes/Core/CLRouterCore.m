//
//  CLRouterCore.m
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterCore.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CLRouterProtocol.h"
#import "CLRouterTargetVCFactory.h"
#import "UIViewController+CLRouter.h"
#import "CLRouterRuntimeHelper.h"

@interface CLRouterCore ()

@end

@implementation CLRouterCore

+ (void)gotoViewControllerWithTargetConfig:(CLRouterTargetConfig *)targetConfig parameters:(NSDictionary *)parameters sourceVC:(UIViewController *)sourceVC callback:(void (^)(BOOL success))callback {
    
    //1.创建目标控制器
    UIViewController *targetVC = [CLRouterTargetVCFactory createTargetVCWithTargetConfig:targetConfig];
    if (!targetVC) {
        if (callback) {
            callback(NO);
        }
        return;
    }
    
    //2.目标控制器处理参数
    if ([targetVC conformsToProtocol:@protocol(CLRouterProtocol)]) {
        //实现了协议的(动态注册)
        if (![self handleRouterDynamicProtocolWithParameters:parameters targetVC:targetVC]) {
            if (callback) {
                callback(NO);
            }
            return;
        }
    } else {
        //未实现协议的(静态注册)
        if (![self handleRouterStaticProtocolWithParameters:parameters targetVC:targetVC]) {
            if (callback) {
                callback(NO);
            }
            return;
        }
    }

    //3.确定源控制器
    if (!sourceVC || ![sourceVC isKindOfClass:[UIViewController class]]) {
        sourceVC = [self findCurrentViewController];
    }

    //4.执行跳转
    [self handleShowWithSourceVC:sourceVC targetVC:targetVC showType:targetConfig.showType];
}


+ (BOOL)handleRouterDynamicProtocolWithParameters:(NSDictionary *)parameters targetVC:(UIViewController *)targetVC {
    UIViewController<CLRouterProtocol> *targetDynamicVC = (UIViewController<CLRouterProtocol> *)targetVC;
    BOOL canHandle = YES; //默认可以处理
    if ([targetDynamicVC respondsToSelector:@selector(canHandleRouterWithParameters:)]) {
        canHandle = [targetDynamicVC canHandleRouterWithParameters:parameters];
    }
    if (!canHandle) {
        return NO;
    }
    if ([targetDynamicVC respondsToSelector:@selector(handleRouterWithParameters:)]) {
        [targetDynamicVC handleRouterWithParameters:parameters];
    }
    return YES;
}

+ (BOOL)handleRouterStaticProtocolWithParameters:(NSDictionary *)parameters targetVC:(UIViewController *)targetVC {
    if (!targetVC) {
        return NO;
    }
    NSArray *properties = [CLRouterRuntimeHelper getClassProperties:[targetVC class]];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([properties containsObject:key]) {
            NSString *propertyName = [NSString stringWithFormat:@"_%@",key];
            [targetVC setValue:obj forKey:propertyName];
        }
    }];
    return YES;
}

+ (UIViewController *)findCurrentViewController {
    return [UIViewController currentViewController];
}

+ (BOOL)handleShowWithSourceVC:(UIViewController *)sourceVC targetVC:(UIViewController *)targetVC showType:(CLRouterShowType)showType {
    switch (showType) {
        case CLRouterShowType_Push:{
            [sourceVC.navigationController pushViewController:targetVC animated:YES];
        }
            break;
        case CLRouterShowType_Present:{
            [sourceVC presentViewController:targetVC animated:YES completion:nil];
        }
            break;
        case CLRouterShowType_Custom:{
            if ([targetVC conformsToProtocol:@protocol(CLRouterProtocol)] && [targetVC respondsToSelector:@selector(handleCustomShowWithSourceVC:targetVC:)]) {
                UIViewController<CLRouterProtocol> *targetDynamicVC = (UIViewController<CLRouterProtocol> *)targetVC;
                [targetDynamicVC handleCustomShowWithSourceVC:sourceVC targetVC:targetDynamicVC];
            } else {
                //默认PUSH
                [sourceVC.navigationController pushViewController:targetVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
    return YES;
}

@end
