//
//  CLRouterDestVCFactory.m
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
    UIViewController *targetVC = [[class alloc] initWithNibName:targetConfig.fileName bundle:[self bundleForResourceWithClass:class bundlePath:targetConfig.bundlePath]];
    return targetVC;
}

+ (UIViewController *)createTargetVCByStoryboardWithTargetConfig:(CLRouterTargetConfig *)targetConfig {
    Class class = NSClassFromString(targetConfig.className);
    UIViewController *targetVC = [[UIStoryboard storyboardWithName:targetConfig.fileName bundle:[self bundleForResourceWithClass:class bundlePath:targetConfig.bundlePath]] instantiateViewControllerWithIdentifier:targetConfig.identifier];
    return targetVC;
}

+ (NSBundle*)bundleForResourceWithClass:(Class)cls bundlePath:(NSString *)bundlePath {
    if (!cls)  {
        return nil;
    }
    NSBundle* bundle = [NSBundle bundleForClass:cls];
    
    if (!bundlePath || bundlePath.length == 0) {
        return bundle;
    }
    NSURL* bundleURL = [[bundle resourceURL] URLByAppendingPathComponent:bundlePath];
    NSBundle* resourceBundle = [NSBundle bundleWithURL:bundleURL];
    return resourceBundle;
}

@end
