//
//  CLRouterTableManager.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRouterTargetConfig.h"
#import "CLRouterTableAccessProtocol.h"

@interface CLRouterTableManager : NSObject <CLRouterTableAccessProtocol>

+ (instancetype)sharedManager;

/**
 获取路由表目标项

 @param scheme 路由表名称
 @param host 路径名称
 @return 目标对象
 */
- (CLRouterTargetConfig *)getRouterTableTargetWithScheme:(NSString *)scheme host:(NSString *)host;

@end
