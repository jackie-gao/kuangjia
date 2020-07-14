//
//  NSObject+LSExtension.h
//
//  Created by larson on 2018/12/20.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

// ----- 一些全局使用的工具 ----- //

#import <UIKit/UIKit.h>

@interface NSObject (LSExtension)
/** 获取当前屏幕显示的viewController*/
- (UIViewController *)getCurrentViewController;

@end
