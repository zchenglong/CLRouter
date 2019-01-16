//
//  CLRouterManager.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterRequest.h"
#import "CLRouterTableAccessProtocol.h"

@protocol CLRouterManagerAccessProtocol

/**
 请求路由跳转
 
 @param routerRequest 请求体，包含请求URL
 @param block 结果回调
 */
- (void)openURLWithRouterRequest:(CLRouterRequest *)routerRequest callback:(void (^)(NSURL *URL, BOOL success))block;

@end

@interface CLRouterManager : NSObject <CLRouterTableAccessProtocol, CLRouterManagerAccessProtocol>

+ (instancetype)sharedManager;

@end
