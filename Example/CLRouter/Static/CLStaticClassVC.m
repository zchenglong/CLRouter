//
//  CLStaticClassVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/28.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLStaticClassVC.h"

@interface CLStaticClassVC ()

@property(strong, nonatomic) UILabel *labContent;

@property(assign, nonatomic) NSInteger code;

@property(copy, nonatomic) NSString *content;

@property(strong, nonatomic) NSNumber *num;

@end

@implementation CLStaticClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    self.labContent = [[UILabel alloc]initWithFrame:CGRectMake(0, height/4.0, width, height/2.0)];
    [self.labContent setText:[NSString stringWithFormat:@"content : %@\ncode : %d\nnum : %@", self.content, (int)self.code,self.num]];
    [self.labContent setNumberOfLines:0];
    [self.view addSubview:self.labContent];
}

@end
