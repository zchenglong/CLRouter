//
//  NSURL+CLRouter.h
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (CLRouter)

/**
 解析一个URL
 
 @param block 回调
 */
- (void)router_parseURLWithCallback:(void(^)(NSString *scheme, NSString *host, NSDictionary *params))block;

@end
