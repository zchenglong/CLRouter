//
//  CLRouterRequest.h
//  CLRouter
//
//  Created by zcl on 2019/1/14.
//  Copyright © 2019年 zcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLRouterRequest : NSObject

// The url to jump. the url's priority is higher than strUrl.
@property(nonatomic, copy) NSURL *url;

// The string url to jump.
@property(nonatomic, copy) NSString *strUrl;

// The additional parameters. default is nil.
@property(nonatomic, copy) NSDictionary *parameters;

// the Source View Controller to jump . default is nil. if nil, this will find current View Controller to jump.
@property(nonatomic, strong) UIViewController *viewController;

@end
