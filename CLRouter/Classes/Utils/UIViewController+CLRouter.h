//
//  UIViewController+CLRouter.h
//  CLRouter
//
//  Created by zcl on 2019/1/28.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CLRouter)

/**
 当前的push容器
 
 @return 返回当前的容器
 */
+ (UINavigationController *)currentNavigationController;

/**
 当前的ViewController
 
 @return 返回当前最上面的ViewController
 */
+ (UIViewController *)currentViewController;

@end
