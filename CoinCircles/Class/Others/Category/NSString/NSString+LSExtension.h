//
//  NSString+LSExtension.h
//
//  Created by larson on 2017/12/24.
//  Copyright © 2017年 larson. All rights reserved.
//

// ----- NSString的一些工具 ----- //

#import <UIKit/UIKit.h>

@interface NSString (LSExtension)

/**
*  根据文字内容获取文字的宽度
*
*  @param height        字体控件的高度
*  @param textFont      字体大小
*
*  @return              文字的宽度
*/
- (CGFloat)getTextWidthWithViewHeight:(CGFloat)height textFont:(UIFont *)textFont;

/**
 *  根据文字内容获取文字的高度
 *
 *  @param width           字体控件的宽度
 *  @param textFont     字体大小
 *
 *  @return             文字的高度
 */
- (CGFloat)getTextHeightWithViewWidth:(CGFloat)width textFont:(UIFont *)textFont;

/**
 *  给手机号第四位至第七位加*
 *
 *  @return             加密的手机号
 */
- (NSString *)phoneNumEncryption;



/** 时间字符串转月日字符串*/
- (NSString *)dateStringConversionMonthAndDay;


/** 随机key*/
+ (NSString *)randomKey;

/** MD5加密, 32位, 小写*/
- (NSString *)MD5;


/**
 *  设置富文本属性
 *
 *  @param beginIndex        开始下标
 *  @param endIndex          结束下标
 *  @param fontSize          字体大小
 *
 *  @return                  带富文本属性的文字
 */
- (NSMutableAttributedString *)setAttributedWithBeginIndex:(NSInteger)beginIndex
                                           endIndex:(NSInteger)endIndex
                                               font:(NSInteger)fontSize;
/**
 *  设置富文本属性
 *
 *  @param beginIndex               开始下标
 *  @param endIndex                 结束下标
 *  @param fontSize                 字体大小
 *  @param attributedTextColor      富文本字体的颜色
 *
 *  @return                         富文本属性文字
 */
- (NSMutableAttributedString *)setAttributedWithBeginIndex:(NSInteger)beginIndex
                                                  endIndex:(NSInteger)endIndex
                                       attributedTextColor:(UIColor *)attributedTextColor
                                                      font:(NSInteger)fontSize;

// 转化html标签为富文本
+ (NSMutableAttributedString *)praseHtmlStr:(NSString *)htmlStr;

// 正则去除网络标签
+ (NSString *)getZZwithString:(NSString *)string;



// *************** 类型判断 *************** //
/** 是否是邮箱*/
- (BOOL)isMobileNumber;

/** 是否是邮箱*/
- (BOOL)isEmail;

/** 车牌号判断*/
- (BOOL)isLicensePlate;

/** 是否含有表情字符*/
- (BOOL)isContainsEmoji;

/**
 * 是否含有特殊字符(中文不属于特殊字符)
 * YES：包含
 */
- (BOOL)isContainsSpecialCharacters;

/** 是否含有特殊字符(中文属于特殊字符)*/
- (BOOL)isContainsSpecialCharactersAndChinese;

/** 是否包含空格*/
- (BOOL)isBlack;




/**
 *  昵称验证(除表情、空格、特殊符号的任意一种或任意组合)
 *
 *  @return         YES：昵称。NO：非昵称
 */
- (BOOL)validateNickName;

/**
 *  邮箱验证
 *
 *  @return         YES：邮箱。NO：非邮箱
 */
- (BOOL)isValidEmail;

/**
 *  电话号码验证
 *
 *  @return         YES：电话号码。NO：非电话号码
 */
- (BOOL)isValidMobileNumber;

/**
 *  验证码验证
 *
 *  @return         YES：验证码。NO：非验证码
 */
- (BOOL)isValidVerifyCode;

/**
 *  姓名验证
 *
 *  @return         YES：姓名。NO：非姓名
 */
- (BOOL)isValidRealName;

/**
 *  只包含中文
 *
 *  @return         YES：只包含中文。NO：包含其他字符
 */
- (BOOL)isOnlyChinese;

/**
 *  银行卡号验证
 *
 *  @return         YES：只包含中文。NO：包含其他字符
 */
- (BOOL)isValidBankCardNumber;

/**
 *  密码验证(有效字母数字密码)
 *
 *  @return         YES：只包含中文。NO：包含其他字符
 */
- (BOOL)isValidAlphaNumberPassword;

@end
