//
//  NSError+CLRouter.h
//  CLRouter
//
//  Created by zcl on 2019/2/1.
//

#import <Foundation/Foundation.h>


static NSInteger const kRouterErrorCode_CreateVC  = 4000101;
static NSInteger const kRouterErrorCode_HandleParamDynamic  = 4000102;
static NSInteger const kRouterErrorCode_HandleParamStatic  = 4000103;
static NSInteger const kRouterErrorCode_FindSourceVC  = 4000104;
static NSInteger const kRouterErrorCode_HandleJump  = 4000105;

static NSInteger const kRouterErrorCode_URLParseError  = 4000201;
static NSInteger const kRouterErrorCode_TargetNotFound  = 4000202;
static NSInteger const kRouterErrorCode_OutsideOpenFailed  = 4000203;

@interface NSError (CLRouter)

+ (instancetype)routerErrorWithCode:(NSInteger)code;

@end
