//
//  CLRouterTargetVCFactory.h
//  CLRouter
//
//  Created by zcl on 2019/1/25.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"

@interface CLRouterTargetVCFactory : NSObject

+ (UIViewController *)createTargetVCWithTargetConfig:(CLRouterTargetConfig *)targetConfig;

@end
