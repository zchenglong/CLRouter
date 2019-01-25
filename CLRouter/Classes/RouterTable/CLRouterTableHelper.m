//
//  CLRouterTableHelper.m
//  CLRouter
//
//  Created by zcl on 2019/1/25.
//

#import "CLRouterTableHelper.h"
#import <objc/runtime.h>

@implementation CLRouterTableHelper

+ (NSArray *)getClassesWhichConfirmToProtocol:(Protocol *)protocol {
    NSMutableArray *classes = [NSMutableArray array];
    unsigned int classCount;
    Class* classList = objc_copyClassList(&classCount);
    
    int i;
    for (i=0; i<classCount; i++) {
        const char *className = class_getName(classList[i]);
        Class thisClass = objc_getClass(className);
        if (class_conformsToProtocol(thisClass, protocol)) {
            [classes addObject:thisClass];
        }
    }
    free(classList);
    return classes;
}

@end
