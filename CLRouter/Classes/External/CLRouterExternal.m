//
//  CLRouterExternal.m
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterExternal.h"
#import <UIKit/UIKit.h>

@implementation CLRouterExternal

+ (void)openOutSideURL:(NSURL *)URL callback:(nullable void (^)(NSURL *, BOOL))block {
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(NO)} completionHandler:^(BOOL success) {
                if (block) {
                    block(URL, success);
                }
#if DEBUG
                if (!success) {
                    NSLog(@"Open fail:%@", URL);
                }
#endif
            }];
        } else {
            if ([[UIApplication sharedApplication] openURL:URL]) {
                if (block) {
                    block(URL, YES);
                }
            } else {
                if (block) {
                    block(URL, NO);
                }
#if DEBUG
                NSLog(@"Open fail:%@", URL);
#endif
            }
        }
    }
}

@end
