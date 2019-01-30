//
//  CLRouterFileHelper.m
//  CLRouter
//
//  Created by zcl on 2019/1/30.
//

#import "CLRouterFileHelper.h"

@implementation CLRouterFileHelper

+ (id)getDataWithFileName:(NSString *)fileName bundle:(NSBundle *)bundle type:(NSString *)type {
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSString *path = [bundle pathForResource:fileName ofType:type];
    if (!path) {
        return nil;
    }
    if ([[type lowercaseString] isEqualToString:@"plist"]) {
        NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:path];
        return dicData;
    } else if ([[type lowercaseString] isEqualToString:@"json"]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSError *error;
        NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        return dicData;
    }
    return nil;
}

@end
