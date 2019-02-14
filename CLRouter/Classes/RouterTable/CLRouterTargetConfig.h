//
//  CLRouterTargetConfig.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLRouterShowType) {
    CLRouterShowType_Push,
    CLRouterShowType_Present,
    CLRouterShowType_Custom
};

typedef NS_ENUM(NSInteger, CLRouterVCType) {
    CLRouterVCType_Class,
    CLRouterVCType_Xib,
    CLRouterVCType_Storyboard
};

@interface CLRouterTargetConfig : NSObject

// Target ViewController Show Type (Push/Present), default is Push
@property(nonatomic, assign) CLRouterShowType showType;

// Target ViewController‘s Create Type (Class/Xib/Storyboard), default is Class
@property(nonatomic, assign) CLRouterVCType vcType;

// Target ViewController's class name (use to class or xib)
@property(nonatomic, copy) NSString *className;

// Target ViewController's xib or storyboard filename (use to xib or storyboard)
@property(nonatomic, copy) NSString *fileName;

// Target ViewController's xib of storyboard identifier
@property(nonatomic, copy) NSString *identifier;

// Target ViewController's resourse like xib or storyboard bundle
@property(nonatomic, copy) NSString *bundlePath;

@end
