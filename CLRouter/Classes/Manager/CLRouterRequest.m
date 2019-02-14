//
//  CLRouterRequest.m
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterRequest.h"

@implementation CLRouterRequest

@end

@implementation CLRouterURLRequest

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

@end

@implementation CLRouterActionRequest

- (instancetype)initWithScheme:(NSString *)scheme host:(NSString *)host {
    if (self = [super init]) {
        self.scheme = scheme;
        self.host = host;
    }
    return self;
}

- (instancetype)initWithScheme:(NSString *)scheme host:(NSString *)host parameters:(NSDictionary *)parameters {
    if (self = [self initWithScheme:scheme host:host]) {
        self.parameters = parameters;
    }
    return self;
}

@end
