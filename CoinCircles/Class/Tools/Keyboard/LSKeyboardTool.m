//
//  AYYKeyboardTool.m
//  larosn
//
//  Created by larson on 2016/10/23.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSKeyboardTool.h"
#import <IQKeyboardManager.h>

@implementation LSKeyboardTool

#pragma mark - <键盘的基本设置>
+ (void)setupKeyboard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.toolbarTintColor = kRGBColor(240, 200, 50);
    keyboardManager.shouldPlayInputClicks = YES;
}

@end
