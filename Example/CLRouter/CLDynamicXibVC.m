//
//  CLDynamicXibVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/28.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLDynamicXibVC.h"

@interface CLDynamicXibVC ()

@property (weak, nonatomic) IBOutlet UILabel *labContent;

@property(assign, nonatomic) NSInteger code;

@property(copy, nonatomic) NSString *content;

@end

@implementation CLDynamicXibVC

#pragma mark - relize CLRouterProtol

+ (CLRouterTargetConfig *)targetConfigForRouter {
    NSLog(@"%s", __func__);
    CLRouterTargetConfig *config = [[CLRouterTargetConfig alloc]init];
    config.vcType = CLRouterVCType_Xib;
    config.className = NSStringFromClass([self class]);
    config.fileName = @"CLDynamicXibVC";
    config.bundle = nil;
    config.showType = CLRouterShowType_Push;
    return config;
}

- (BOOL)canHandleRouterWithParameters:(NSDictionary *)parameters {
    NSLog(@"%s | parameter = %@", __func__, parameters);
    return YES;
}

- (void)handleRouterWithParameters:(NSDictionary *)parameters {
    NSLog(@"%s | parameter = %@", __func__, parameters);
    self.code = ((NSNumber *)parameters[@"code"]).integerValue;
    self.content = parameters[@"content"];
}

# pragma system initialize


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.labContent setText:[NSString stringWithFormat:@"content : %@\ncode : %d", self.content, (int)self.code]];
}

@end
