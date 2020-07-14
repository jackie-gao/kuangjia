//
//  LSMaskTool.m
//  larson
//
//  Created by larson on 2016/10/23.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSMaskTool.h"
#import <SVProgressHUD.h>

@implementation LSMaskTool

// =============== 状态 =============== //
#pragma mark - <成功提示>
+ (void)showSucceessMessage:(NSString *)successMessage
{
    [LSMaskTool showSucceessMessage:successMessage duration:1.5];
}

+ (void)showSucceessMessage:(NSString *)successMessage duration:(CGFloat)duration
{
    // 设置时间必须在显示之前
    [SVProgressHUD setMaximumDismissTimeInterval:duration];
    [SVProgressHUD showSuccessWithStatus:successMessage];
    // HUD的样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    // 蒙版的样式
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}


#pragma mark - <失败提示>
+ (void)showErrorMessage:(NSString *)errorMessage
{
    [LSMaskTool showErrorMessage:errorMessage duration:1.5];
}

+ (void)showErrorMessage:(NSString *)errorMessage duration:(CGFloat)duration
{
    [SVProgressHUD setMaximumDismissTimeInterval:duration];
    [SVProgressHUD showErrorWithStatus:errorMessage];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}


#pragma mark - <状态提示>
+ (void)showInfoMessage:(NSString *)infoMessage
{
    [LSMaskTool showInfoMessage:infoMessage duration:1.5];
}

+ (void)showInfoMessage:(NSString *)infoMessage duration:(CGFloat)duration
{
    [SVProgressHUD setMaximumDismissTimeInterval:duration];
    [SVProgressHUD showInfoWithStatus:infoMessage];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}





// =============== 加载 =============== //
#pragma mark - <加载>
+ (void)showLoad
{
    [LSMaskTool showLoadWithMeaasge:nil];
}

+ (void)showLoadWithMeaasge:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

+ (void)showLoadWithMask
{
    [LSMaskTool showLoadWithMaskAndMessage:nil];
}

+ (void)showLoadWithMaskAndMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}





// =============== 进度 =============== //
#pragma mark - <进度>
+ (void)showProgress:(CGFloat)progress
{
    [SVProgressHUD showProgress:progress status:nil];
}

+ (void)showProgress:(CGFloat)progress message:(NSString *)message
{
    [SVProgressHUD showProgress:progress status:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}





// =============== 自定义提示信息 =============== //
#pragma mark - <文字提示>
// 文字提示
+ (void)showMessage:(NSString *)message
{
    [LSMaskTool showMessage:message duration:1.5];
}

// 可以设置时长的文字提示
+ (void)showMessage:(NSString *)message duration:(CGFloat)duration
{
    [SVProgressHUD setMaximumDismissTimeInterval:duration];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:message];
}


#pragma mark - <图片提示>
// 图片提示
+ (void)showImage:(NSString *)imageNamed
{
    [LSMaskTool showImage:imageNamed message:nil duration:1.5];
}

// 可以设置时长的图片提示
+ (void)showImage:(NSString *)imageNamed duration:(CGFloat)duration
{
    [LSMaskTool showImage:imageNamed message:nil duration:duration];
}


#pragma mark <图片和文字提示>
// 图片和文字提示
+ (void)showImage:(NSString *)imageNamed message:(NSString *)message
{
    [LSMaskTool showImage:imageNamed message:message duration:1.5];
}

// 可以设置时长的图片和文字提示
+ (void)showImage:(NSString *)imageNamed message:(NSString *)message duration:(CGFloat)duration
{
    CGFloat WH = UIScreen.mainScreen.bounds.size.width / 3;
    [SVProgressHUD setMaximumDismissTimeInterval:duration];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:[UIImage imageNamed:imageNamed] status:message];
    [SVProgressHUD setImageViewSize:CGSizeMake(WH, WH)];
}




// =============== dismiss =============== //
#pragma mark - <消失>
+ (void)dismiss
{
    [SVProgressHUD popActivity];
    [SVProgressHUD dismiss];
}

@end
