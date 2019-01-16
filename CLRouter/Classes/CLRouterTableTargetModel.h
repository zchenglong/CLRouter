//
//  CLRouterTableTargetModel.h
//  CLRouter
//
//  Created by zcl on 2019/1/11.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLRouterShowType) {
    CLRouterShowType_Push,
    CLRouterShowType_Present
};

typedef NS_ENUM(NSInteger, CLRouterVCType) {
    CLRouterVCType_Class,
    CLRouterVCType_Xib,
    CLRouterVCType_Storyboard
};

@interface CLRouterTableTargetModel : NSObject

// Target ViewController Show Type (Push/Present), default is Push
@property(nonatomic, assign) CLRouterShowType *showType;

// Target ViewController‘s Create Type (Class/Xib/Storyboard), default is Class
@property(nonatomic, assign) CLRouterVCType *vcType;

// Target ViewController's class name (use to class)
@property(nonatomic, copy) NSString *className;

// Target ViewController's xib or storyboard filename (use to xib or storyboard)
@property(nonatomic, copy) NSString *fileName;

// Target ViewController's xib of storyboard identifier
@property(nonatomic, copy) NSString *identifier;

// Target ViewController's resourse like xib or storyboard bundleName
@property(nonatomic, copy) NSString *bundleName;

@end
