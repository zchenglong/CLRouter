//
//  CLRouterRuntimeHelper.h
//  CLRouter
//
//  Created by zcl on 2019/1/30.
//

#import <Foundation/Foundation.h>

@interface CLRouterRuntimeHelper : NSObject

+ (NSArray *)getClassesWhichConfirmToProtocol:(Protocol *)protocol;

+ (NSArray<NSString *> *)getClassProperties:(Class)cls;

@end
