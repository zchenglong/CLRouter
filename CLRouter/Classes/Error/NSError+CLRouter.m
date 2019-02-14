//
//  NSError+CLRouter.m
//  CLRouter
//
//  Created by zcl on 2019/2/1.
//

#import "NSError+CLRouter.h"

static NSString * const CLRouterDomain = @"com.zchenglong.router.domain";

static NSMutableDictionary *dicErrorMsgs;

@implementation NSError (CLRouter)

+ (void)initialize {
    dicErrorMsgs = [NSMutableDictionary dictionary];
    [self addErrorMsgs];
}

+ (void)addErrorMsgs {
    @synchronized(dicErrorMsgs) {
        dicErrorMsgs[@(kRouterErrorCode_CreateVC)] = @"Create View Controller or Class error!";
        dicErrorMsgs[@(kRouterErrorCode_HandleParamDynamic)] = @"Handle Parameters setting (dynamic) for View Controller error!";
        dicErrorMsgs[@(kRouterErrorCode_HandleParamStatic)] = @"Handle Parameters setting (static) for View Controller error!";
        dicErrorMsgs[@(kRouterErrorCode_FindSourceVC)] = @"Can not found the source view controller!";
        dicErrorMsgs[@(kRouterErrorCode_HandleJump)] = @"Handle Jump in view controllers failed!";
        
        dicErrorMsgs[@(kRouterErrorCode_URLParseError)] = @"the input url parse error!";
        dicErrorMsgs[@(kRouterErrorCode_TargetNotFound)] = @"can not found the target config in router table!";
        dicErrorMsgs[@(kRouterErrorCode_OutsideOpenFailed)] = @"open url with outside failed!";
    }
}

+ (instancetype)routerErrorWithCode:(NSInteger)code {
    return [self errorWithDomain:CLRouterDomain code:code userInfo:@{@"msg":[self routerErrorMsgWithCode:code]}];
}

+ (NSString *)routerErrorMsgWithCode:(NSInteger)code {
    return dicErrorMsgs[@(code)] ?: @"can not found reason!";
}

@end
