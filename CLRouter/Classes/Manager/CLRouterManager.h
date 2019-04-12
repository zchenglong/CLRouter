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
#import "CLRouterDefine.h"

@protocol CLRouterManagerAccessProtocol

/**
 请求路由跳转(URL)
 
 @param routerRequest 请求体，包含请求URL
 @param callback 结果回调
 */
- (void)openURLWithRouterRequest:(CLRouterURLRequest *)routerRequest callback:(RouterURLCallback)callback;

/**
 请求路由跳转（Action）

 @param routerRequest 请求体，包含scheme、host
 @param callback 结果回调
 */
- (void)actionWithRouterRequest:(CLRouterActionRequest *)routerRequest callback:(RouterActionCallback)callback;

@end

@interface CLRouterManager : NSObject <CLRouterTableAccessProtocol, CLRouterManagerAccessProtocol>

+ (instancetype)sharedManager;

@end
