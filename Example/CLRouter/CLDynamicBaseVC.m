//
//  CLDynamicBaseVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/28.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLDynamicBaseVC.h"

@interface CLDynamicBaseVC ()

@end

@implementation CLDynamicBaseVC

#pragma mark - relize CLRouterProtocol

+ (NSString *)schemeForRouter {
    NSLog(@"%s", __func__);
    return @"SmartTourism";
}

+ (NSString *)hostForRouter {
    NSLog(@"%s", __func__);
    return NSStringFromClass([self class]);
}

+ (CLRouterTargetConfig *)targetConfigForRouter {
    NSLog(@"%s", __func__);
    //基类默认
    CLRouterTargetConfig *config = [[CLRouterTargetConfig alloc]init];
    config.className = NSStringFromClass([self class]);
    config.showType = CLRouterShowType_Push;
    return config;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:NSStringFromClass([self class])];
}


@end
