//
//  CLStaticXibVC.m
//  CLRouter_Example
//
//  Created by zcl on 2019/1/28.
//  Copyright © 2019年 zhangchenglong. All rights reserved.
//

#import "CLStaticXibVC.h"

@interface CLStaticXibVC ()

@property (weak, nonatomic) IBOutlet UILabel *labContent;

@property(assign, nonatomic) NSInteger code;

@property(copy, nonatomic) NSString *content;

@end

@implementation CLStaticXibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.labContent setText:[NSString stringWithFormat:@"content : %@\ncode : %d", self.content, (int)self.code]];
}


@end
