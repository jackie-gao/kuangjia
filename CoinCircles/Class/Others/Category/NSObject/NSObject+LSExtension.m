//
//  NSObject+LSExtension.m
//
//  Created by larson on 2018/12/20.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

#import "NSObject+LSExtension.h"

@implementation NSObject (LSExtension)

// 获取当前屏幕显示的viewController
- (UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = UIApplication.sharedApplication.windows;
        for (UIWindow *tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    // 如果是present出来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        // 多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            } else {
                break;
            }
        }
    }
    else {
        UIView *frontView = window.subviews.firstObject;
        nextResponder = frontView.nextResponder;
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)nextResponder;
        UINavigationController *navVC = tabBarVC.viewControllers[tabBarVC.selectedIndex];
        result = navVC.childViewControllers.lastObject;
    }
    else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController *navVC = (UIViewController *)nextResponder;
        result = navVC.childViewControllers.lastObject;
    }
    else {
        result = nextResponder;
    }
    
    return result;
}

@end
