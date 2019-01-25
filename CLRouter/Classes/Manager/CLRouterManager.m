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

- (instancetype)init {
    if (self = [super init]) {
        [self registerRouterTableFromClassWhichConfirmToProtocol];
    }
    return self;
}

- (void)registerRouterTableFromClassWhichConfirmToProtocol {
    [[CLRouterTableManager sharedManager] registerRouterTableFromClassWhichConfirmToProtocol];
}

#pragma mark - CLRouterTableAccessProtocol

- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithFilePath:filePath];
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *,CLRouterTargetConfig *> *)parameters {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithScheme:scheme parameters:parameters];
}

#pragma mark - CLRouterManagerAccessProtocol

- (void)openURLWithRouterRequest:(CLRouterRequest *)routerRequest callback:(void (^)(NSURL *URL, BOOL success))callback {
    NSURL *realURL = [self getRealURLWithRouterRequest:routerRequest];
    if (!realURL) {
        if (callback) {
            callback(realURL, NO);
        }
        return;
    }
    //解析URL
    __weak typeof(self) weakSelf = self;
    [realURL router_parseURLWithCallback:^(NSString *scheme, NSString *host, NSDictionary *params) {
        __strong typeof(self) strongSelf = weakSelf;
        CLRouterTargetConfig *targetModel = [[CLRouterTableManager sharedManager] getRouterTableTargetWithScheme:scheme host:host];
        if (!targetModel) {
            //external handler
            [strongSelf handleExternalRouterWithURL:realURL callback:callback];
            return;
        }
        //router core handler
        [strongSelf handleRouterWithTarget:targetModel parameters:params routerRequest:routerRequest url:realURL callback:callback];
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

- (void)handleExternalRouterWithURL:(NSURL *)url callback:(void (^)(NSURL *URL, BOOL success))callback {
    [CLRouterExternal openOutSideURL:url callback:^(NSURL *URL, BOOL success) {
        if (callback) {
            callback(URL, success);
        }
    }];
}

- (void)handleRouterWithTarget:(CLRouterTargetConfig *)target parameters:(NSDictionary *)parameters routerRequest:(CLRouterRequest *)routerRequest url:(NSURL *)url callback:(void (^)(NSURL *URL, BOOL success))callback {
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionary];
    if (parameters) {
        [dicParams setDictionary:parameters];
    }
    if (routerRequest.parameters) {
        [dicParams setDictionary:routerRequest.parameters];
    }
    [CLRouterCore gotoViewControllerWithTargetConfig:target parameters:parameters sourceVC:routerRequest.viewController callback:^(BOOL success) {
        if (callback) {
            callback(url, success);
        }
    }];
}


@end
