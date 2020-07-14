//
//  SSJDAlertController.h
//  shanShuiHotel
//
//  Created by larson on 2018/12/28.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

// ----- 封装该应用使用alert ----- //

#import <UIKit/UIKit.h>

@interface LSAlertController : UIAlertController

/**
 中间弹出的选择样式
 @param title       显示的标题
 @param message     显示的副标题
 @param fromVC      推出alert的控制器
 @param completion  完成之后的block，获取输入框输入的数据
 */
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title
                                message:(NSString *)message
                                 fromVC:(UIViewController *)fromVC
                          completeBlock:(void(^)(NSString *inputValue))completion;

/**
 * 自定义的中间弹出样式
 *
 * @param title                        标题
 * @param titleColor                   标题的字体颜色
 * @param titleFont                    标题的字体大小
 * @param message                      提示内容
 * @param messageColor                 提示内容的字体颜色
 * @param messageFont                  提示内容的的字体大小
 * @param leftActionText               左边action的内容
 * @param leftActionColor              左边action的字体颜色
 * @param rightActionText              右边action的内容
 * @param rightActionColor             右边action的字体颜色
 * @param actionFont                   action的字体大小，修改之后会改变所有的alertView的action的字体大小
 * @param fromVC                       推出alert的控制器
 * @param leftActionHandleBlock        左边action点击后的操作
 * @param rightActionHandleBlock       右边action点击后的操作
 */
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor
                              titleFont:(UIFont *)titleFont
                                message:(NSString *)message
                           messageColor:(UIColor *)messageColor
                            messageFont:(UIFont *)messageFont
                         leftActionText:(NSString *)leftActionText
                        leftActionColor:(UIColor *)leftActionColor
                        rightActionText:(NSString *)rightActionText
                       rightActionColor:(UIColor *)rightActionColor
                             actionFont:(UIFont *)actionFont
                                 fromVC:(UIViewController *)fromVC
                  leftActionHandleBlock:(void(^)(void))leftActionHandleBlock
                 rightActionHandleBlock:(void(^)(void))rightActionHandleBlock;


/**
 带输入框的中间弹框样式
@param title       显示的标题
@param message     显示的副标题
@param fromVC      推出alert的控制器
@param completion  完成之后的block，获取输入框输入的数据
*/
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title
                                message:(NSString *)message
                         textPlaechodle:(NSString *)placehodle
                                 fromVC:(UIViewController *)fromVC
                          completeBlock:(void(^)(NSString *inputValue))completion;


/**
 选择性别
 @param color       字体颜色
 @param font        字体大小
 @param fromVC      推出alert的控制器
 @param completion  完成之后的block，获取输入框输入的数据
 */
+ (void)selectSexWithTextColor:(UIColor *)color
                          font:(UIFont *)font
                        fromVC:(UIViewController *)fromVC
                 completeBlock:(void(^)(NSString *sex))completion;



/**
 提示用户打开权限
 @param text                      提示的内容信息
 */
+ (void)alertUserToOpenPermissions:(NSString *)text;

@end
