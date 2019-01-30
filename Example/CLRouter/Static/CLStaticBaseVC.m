//
//  CLStaticBaseVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/30.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLStaticBaseVC.h"

@interface CLStaticBaseVC ()

@end

@implementation CLStaticBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:NSStringFromClass([self class])];
}

@end
