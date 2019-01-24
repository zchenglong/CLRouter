//
//  CLRouterManager.m
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import "CLRouterManager.h"
#import "CLRouterTableManager.h"
#import "NSURL+CLRouter.h"
#import "CLRouterCore.h"
#import "CLRouterExternal.h"

@interface CLRouterManager ()

@end

@implementation CLRouterManager

+ (instancetype)sharedManager {
    static CLRouterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

#pragma mark - CLRouterTableAccessProtocol

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme filePath:(NSString *)filePath {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithScheme:scheme filePath:filePath];
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary *)parameters {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithScheme:scheme parameters:parameters];
}

#pragma mark - CLRouterManagerAccessProtocol

- (void)openURLWithRouterRequest:(CLRouterRequest *)routerRequest callback:(void (^)(NSURL *URL, BOOL success))block {
    NSURL *realURL = [self getRealURLWithRouterRequest:routerRequest];
    if (!realURL) {
        block(realURL, NO);
        return;
    }
    //解析URL
    [realURL router_parseURLWithCallback:^(NSString *scheme, NSString *host, NSDictionary *params) {
        CLRouterTargetConfig *targetModel = [[CLRouterTableManager sharedManager] getRouterTableTargetWithScheme:scheme host:host];
        if (!targetModel) {
            //external handler
            [self handleExternalRouterWithURL:realURL callback:block];
            return;
        }
        //router core handler
        [self handleRouterWithTarget:targetModel parameters:params routerRequest:routerRequest url:realURL callback:block];
        
    }];
}

#pragma mark - PRIVATE METHOD

- (NSURL *)getRealURLWithRouterRequest:(CLRouterRequest *)routerRequest {
    if (routerRequest.url) {
        return routerRequest.url;
    }
    if (routerRequest.strUrl) {
        return [NSURL URLWithString:routerRequest.strUrl];
    }
    return nil;
}

- (void)handleExternalRouterWithURL:(NSURL *)url callback:(void (^)(NSURL *URL, BOOL success))block {
    [CLRouterExternal openOutSideURL:url callback:^(NSURL *URL, BOOL success) {
        block(URL, success);
    }];
}

- (void)handleRouterWithTarget:(CLRouterTargetConfig *)target parameters:(NSDictionary *)parameters routerRequest:(CLRouterRequest *)routerRequest url:(NSURL *)url callback:(void (^)(NSURL *URL, BOOL success))block {
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionary];
    if (parameters) {
        [dicParams setDictionary:parameters];
    }
    if (routerRequest.parameters) {
        [dicParams setDictionary:routerRequest.parameters];
    }
    [CLRouterCore gotoViewControllerWithTarget:target parameters:dicParams viewController:routerRequest.viewController callback:^(BOOL success) {
        block(url, success);
    }];
}


@end
