//
//  CLRouterTargetVCFactory.m
//  CLRouter
//
//  Created by zcl on 2019/1/25.
//

#import "CLRouterTargetVCFactory.h"
#import <UIKit/UIKit.h>

@implementation CLRouterTargetVCFactory

+ (UIViewController *)createTargetVCWithTargetConfig:(CLRouterTargetConfig *)targetConfig {
    UIViewController *targetVC = nil;
    switch (targetConfig.vcType) {
        case CLRouterVCType_Class: {
            targetVC = [self createTargetVCByClassWithTargetConfig:targetConfig];
        }
            break;
        case CLRouterVCType_Xib: {
            targetVC = [self createTargetVCByXibWithTargetConfig:targetConfig];
        }
            break;
        case CLRouterVCType_Storyboard: {
            targetVC = [self createTargetVCByStoryboardWithTargetConfig:targetConfig];
        }
            break;
            
        default:
            break;
    }
    return targetVC;
}

+ (UIViewController *)createTargetVCByClassWithTargetConfig:(CLRouterTargetConfig *)targetConfig {
    Class class = NSClassFromString(targetConfig.className);
    UIViewController *targetVC = [[class alloc]init];
    return targetVC;
}

+ (UIViewController *)createTargetVCByXibWithTargetConfig:(CLRouterTargetConfig *)targetConfig {
    Class class = NSClassFromString(targetConfig.className);
    UIViewController *targetVC = [[class alloc] initWithNibName:targetConfig.fileName bundle:targetConfig.bundle];
    return targetVC;
}

+ (UIViewController *)createTargetVCByStoryboardWithTargetConfig:(CLRouterTargetConfig *)targetConfig {
    UIViewController *targetVC = [[UIStoryboard storyboardWithName:targetConfig.fileName bundle:targetConfig.bundle] instantiateViewControllerWithIdentifier:targetConfig.identifier];
    return targetVC;
}

@end
