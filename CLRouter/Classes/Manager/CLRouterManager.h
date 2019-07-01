//
//  CLRouterManager.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterAccessProtocol.h"

@interface CLRouterManager : NSObject <CLRouterTableAccessProtocol, CLRouterManagerAccessProtocol>

+ (instancetype)sharedManager;

@end
