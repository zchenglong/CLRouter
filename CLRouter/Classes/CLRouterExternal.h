//
//  CLRouterExternal.h
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRouterExternal : NSObject

/**
 跳转外部

 @param URL url路由
 @param block 回调
 */
+ (void)openOutSideURL:(NSURL *)URL callback:(void (^)(NSURL *URL, BOOL success))block;

@end
