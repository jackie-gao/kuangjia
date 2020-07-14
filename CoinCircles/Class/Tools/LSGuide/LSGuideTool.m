//
//  LSGuideTool.m
//
//  Created by larson on 2016/10/27.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSGuideTool.h"
#import "ZXKJTabBarController.h"
#import "LSGuideViewController.h"
#import "LSSaveTool.h"

@implementation LSGuideTool

#pragma mark - 选择根控制器
+ (UIViewController *)chooseRootViewController
{
    UIViewController *rootVC = nil;
    rootVC = [[ZXKJTabBarController alloc]init];
    
    
    
//    // 版本号
//    NSString *curVersion = kAppReleaseVersion;
//    NSString *oldVersion = kUserDefaultsGetStringWithKey(ZCKJGuidePageVersionKey);
//
//    if ([curVersion isEqualToString:oldVersion]) {  // 没有新版本
//        rootVC = [[ZXKJTabBarController alloc]init];
//    }
//    else {  // 有新版
//        rootVC = [[LSGuideViewController alloc]init];
//    }
    
    return rootVC;
}

@end
