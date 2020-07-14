//
//  LSCustomNavigationBar.h
//  2.自定义导航栏
//
//  Created by larson on 2018/12/31.
//  Copyright © 2018年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCustomNavigationBar : UIView

/** 点击左边的按钮*/
@property(nonatomic,copy) void(^onClickLeftButton)(void);
/** 点击右边的按钮*/
@property(nonatomic,copy) void(^onClickRightButton)(void);

/** title*/
@property(nonatomic,copy) NSString *title;
/** title的字体颜色*/
@property(nonatomic,strong) UIColor *titleLabelColor;
/** titleLabel的alpha*/
@property(nonatomic,assign) CGFloat titleLabelAlpha;
/** title的字体大小*/
@property(nonatomic,strong) UIFont *titleLabelFont;
/** 导航栏的背景色*/
@property(nonatomic,strong) UIColor *barBackgroundColor;
/** 导航栏的背景图片*/
@property(nonatomic,strong) UIImage *barBackgroundImage;


/** 创建自定义的导航栏*/
+ (instancetype)customNavigationBar;

/** 导航栏底部线条是否隐藏*/
- (void)LS_setBottomLineHidden:(BOOL)hidden;

/** 导航栏的背景透明度*/
- (void)LS_setBackgroundAlpha:(CGFloat)alpha;

/** 设置导航栏的主题色*/
- (void)LS_setTintColor:(UIColor *)color;

/**
 *  给左边的按钮设置图片
 *
 *  @param image       图片
 */
- (void)LS_setLeftButtonWithImage:(UIImage *)image;

/**
 *  给左边的按钮设置图片和高亮图片
 *
 *  @param normalImage       图片
 *  @param highlightedImage  高亮图片
 */
- (void)LS_setLeftButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage;

/**
 *  给左边的按钮设置文字和文字颜色
 *
 *  @param title       文字
 *  @param titleColor  文字颜色
 */
- (void)LS_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;


/**
 *  给右边的按钮设置图片
 *
 *  @param image       图片
 */
- (void)LS_setRightButtonWithImage:(UIImage *)image;

/**
 *  给右边的按钮设置图片和高亮图片
 *
 *  @param image       图片
 *  @param highlightedImage  高亮图片
 */
- (void)LS_setRightButtonWithNormalImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

/**
 *  给右边的按钮设置文字和文字颜色
 *
 *  @param title       文字
 *  @param titleColor  文字颜色
 */
- (void)LS_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



@end
