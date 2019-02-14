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
#import "NSError+CLRouter.h"

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

- (BOOL)registerRouterTableDynamic {
    return [[CLRouterTableManager sharedManager] registerRouterTableDynamic];
}

- (BOOL)registerRouterTableWithFilePath:(NSString *)filePath bundle:(NSBundle *)bundle {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithFilePath:filePath bundle:bundle];
}

- (BOOL)registerRouterTableWithScheme:(NSString *)scheme parameters:(NSDictionary<NSString *,CLRouterTargetConfig *> *)parameters {
    return [[CLRouterTableManager sharedManager] registerRouterTableWithScheme:scheme parameters:parameters];
}

#pragma mark - CLRouterManagerAccessProtocol

- (void)openURLWithRouterRequest:(CLRouterURLRequest *)routerRequest callback:(RouterURLCallback)callback {
    NSURL *realURL = [self getRealURLWithRouterRequest:routerRequest];
    if (!realURL) {
        if (callback) {
            callback(realURL, [NSError routerErrorWithCode:kRouterErrorCode_URLParseError]);
        }
        return;
    }
    //解析URL
    __weak typeof(self) weakSelf = self;
    [realURL router_parseURLWithCallback:^(NSString *scheme, NSString *host, NSDictionary *params) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (![[CLRouterTableManager sharedManager] isSchemeExist:scheme]) {
            //external handler
            [self handleExternalRouterWithURL:realURL callback:callback];
            return;
        }
        
        NSMutableDictionary *dicParams = [NSMutableDictionary dictionary];
        if (params) {
            [dicParams setDictionary:params];
        }
        if (routerRequest.parameters) {
            [routerRequest.parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    [dicParams setObject:obj forKey:key];
                }
            }];
        }
        CLRouterActionRequest *routerActionRequest = [[CLRouterActionRequest alloc]initWithScheme:scheme host:host
                                                                                       parameters:dicParams];
        [strongSelf actionWithRouterRequest:routerActionRequest callback:^(NSError *error) {
            if (callback) {
                callback(realURL, error);
            }
        }];
    }];
}


- (void)actionWithRouterRequest:(CLRouterActionRequest *)routerRequest callback:(RouterActionCallback)callback {
    CLRouterTargetConfig *targetModel = [[CLRouterTableManager sharedManager] getRouterTableTargetWithScheme:routerRequest.scheme host:routerRequest.host];
    if (!targetModel) {
        if (callback) {
            callback([NSError routerErrorWithCode:kRouterErrorCode_TargetNotFound]);
        }
        return;
    }
    //router core handler
    [self handleRouterWithTarget:targetModel routerRequest:routerRequest callback:callback];
}

#pragma mark - PRIVATE METHOD

- (NSURL *)getRealURLWithRouterRequest:(CLRouterURLRequest *)routerRequest {
    if (routerRequest.url) {
        return routerRequest.url;
    }
    if (routerRequest.strUrl) {
        return [NSURL URLWithString:routerRequest.strUrl];
    }
    return nil;
}

- (void)handleExternalRouterWithURL:(NSURL *)url callback:(RouterURLCallback)callback {
    [CLRouterExternal openOutSideURL:url callback:^(NSURL *URL, BOOL success) {
        if (callback) {
            callback(URL, success ? nil : [NSError routerErrorWithCode:kRouterErrorCode_OutsideOpenFailed]);
        }
    }];
}

- (void)handleRouterWithTarget:(CLRouterTargetConfig *)target routerRequest:(CLRouterActionRequest *)routerRequest callback:(RouterActionCallback)callback {
    [CLRouterCore gotoViewControllerWithTargetConfig:target parameters:routerRequest.parameters sourceVC:routerRequest.sourceVC callback:^(NSError *error) {
        if (callback) {
            callback(error);
        }
    }];
}


@end
