//
//  CLDynamicClassVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/28.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLDynamicClassVC.h"

@interface CLDynamicClassVC ()

@property(strong, nonatomic) UILabel *labContent;

@property(assign, nonatomic) NSInteger code;

@property(copy, nonatomic) NSString *content;

@end

@implementation CLDynamicClassVC

#pragma mark - relize CLRouterProtol

+ (CLRouterTargetConfig *)targetConfigForRouter {
    NSLog(@"%s", __func__);
    CLRouterTargetConfig *config = [[CLRouterTargetConfig alloc]init];
    config.className = NSStringFromClass([self class]);
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
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    self.labContent = [[UILabel alloc]initWithFrame:CGRectMake(0, height/4.0, width, height/2.0)];
    [self.labContent setText:[NSString stringWithFormat:@"content : %@\ncode : %d", self.content, (int)self.code]];
    [self.labContent setNumberOfLines:0];
    [self.view addSubview:self.labContent];
}




@end
