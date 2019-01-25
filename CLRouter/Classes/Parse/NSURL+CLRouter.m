//
//  NSURL+CLRouter.m
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "NSURL+CLRouter.h"

@implementation NSURL (CLRouter)

- (void)router_parseURLWithCallback:(void(^)(NSString *scheme, NSString *host, NSDictionary *params))block {
    if (block) {
        NSString *scheme = self.scheme;
        NSString *host = self.host;
        
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
        NSMutableDictionary *queryItemDict = [NSMutableDictionary dictionary];
        NSArray *queryItems = urlComponents.queryItems;
        for (NSURLQueryItem *item in queryItems) {
            [queryItemDict setObject:item.value forKey:item.name];
        }
        block(scheme, host, queryItemDict);
    }
}

@end
