//
//  LSMaskTool.h
//  larson
//
//  Created by larson on 2016/10/23.
//  Copyright © 2016年 larson. All rights reserved.
//

// ----- HUD(基于SVProgressHUD) ----- //

#import <Foundation/Foundation.h>

@interface LSMaskTool : NSObject

// =============== 状态 =============== //
// 成功提示
/**
 *  成功提示，默认显示时长为1.5s
 *
 *  @param successMessage   需要显示的文字
 */
+ (void)showSucceessMessage:(NSString *)successMessage;

/**
 *  自定义时长的成功提示
 *
 *  @param successMessage   需要显示的文字
 *  @param duration         显示时长
 */
+ (void)showSucceessMessage:(NSString *)successMessage
                   duration:(CGFloat)duration;


// 错误提示
/**
 *  错误提示，默认显示时长为1.5s
 *
 *  @param errorMessage   需要显示的文字
 */
+ (void)showErrorMessage:(NSString *)errorMessage;

/**
 *  自定义时长的错误提示
 *
 *  @param errorMessage     需要显示的文字
 *  @param duration         显示时长
 */
+ (void)showErrorMessage:(NSString *)errorMessage
                duration:(CGFloat)duration;


// 状态提示
/**
 *  状态提示，默认显示时长为1.5s
 *
 *  @param infoMessage      需要显示的文字
 */
+ (void)showInfoMessage:(NSString *)infoMessage;

/**
 *  自定义时长info提示
 *
 *  @param infoMessage      需要显示的文字
 *  @param duration         显示时长
 */
+ (void)showInfoMessage:(NSString *)infoMessage
                 duration:(CGFloat)duration;





// =============== 加载 =============== //
/**
 *  加载
 *  默认设置：无时长限制、无蒙版、可以穿透
 */
+ (void)showLoad;

/**
 *  提示文字的加载
 *  默认设置：无时长限制、无蒙版、不可穿透
 *
 *  @param message   需要显示的文字
 */
+ (void)showLoadWithMeaasge:(NSString *)message;

/**
 *  带蒙版的加载
 *  默认设置：无时长限制、白底、蒙版为黑色、不可穿透
 */
+ (void)showLoadWithMask;

/**
 *  带蒙版可以显示文字信息的加载
 *  默认设置：无时长限制、白底、蒙版为黑色、不可穿透
 *
 * @param message   需要显示的文字
 */
+ (void)showLoadWithMaskAndMessage:(NSString *)message;





// =============== 进度 =============== //
/** 带蒙版的进度*/
+ (void)showProgress:(CGFloat)progress;

/**
 *  带蒙版和提示的进度
 *@param    progress   进度
 *
 * @param   message   需要显示的文字
 */
+ (void)showProgress:(CGFloat)progress message:(NSString *)message;





// =============== 自定义信息 =============== //
// 文字信息
/**
 *  需要显示的文字信息，默认显示时长为1.5s
 *
 *  @param message   需要显示的文字
 */
+ (void)showMessage:(NSString *)message;

/**
 *  可以设置时长的文字信息
 *
 *  @param message   需要显示的文字
 *  @param duration  显示时长
 */
+ (void)showMessage:(NSString *)message
           duration:(CGFloat)duration;


// 图片信息
/**
 *  需要显示的图片，默认显示时长为1.5s
 *
 *  @param imageNamed   需要显示图片的图片名
 */
+ (void)showImage:(NSString *)imageNamed;

/**
 *  可以设置时长的图片
 *
 *  @param imageNamed   需要显示图片的图片名
 *  @param duration     显示时长
 */
+ (void)showImage:(NSString *)imageNamed
         duration:(CGFloat)duration;


// 图片和文字信息
/**
 *  图片和文字信息，默认显示时长为1.5s
 *
 *  @param imageNamed   需要显示图片的图片名
 *  @param message      需要显示的文字
 */
+ (void)showImage:(NSString *)imageNamed
          message:(NSString *)message;

/**
 *  自定义时长的图片和文字信息
 *
 *  @param imageNamed   需要显示图片的图片名
 *  @param message      需要显示的文字
 *  @param duration     显示时长
 */
+ (void)showImage:(NSString *)imageNamed
          message:(NSString *)message
         duration:(CGFloat)duration;





// =============== HUD消失 =============== //
/** 消失*/
+ (void)dismiss;

@end
