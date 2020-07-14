//
//  LSNavigationBar.h
//
//  Created by larson on 2019/1/5.
//  Copyright © 2019年 larosn. All rights reserved.
//

// 修改系统的LSNavigationBar

#import <UIKit/UIKit.h>

@class LSCustomNavigationBar;

@interface LSNavigationBar : UIView

/** 是否是刘海屏*/
+ (BOOL)isLiuHaiScreen;
/** 导航栏底部的高度*/
+ (CGFloat)navigationBarBottom;
/** tabBar的高度*/
+ (CGFloat)tabBarHeight;
/** 屏幕的宽度*/
+ (CGFloat)screenWidth;
/** 屏幕的高度*/
+ (CGFloat)screenHeight;

@end





#pragma mark - <该类的分类>
@interface LSNavigationBar (LSDefault)

// 功能还不完善，有待完善(局部使用)
+ (void)LS_local;

/** 作用有待测试*/
+ (void)LS_widely;

// 设置需要用到的控制器(有待完善)
+ (void)LS_setWhiteList:(NSArray<NSString *> *)whiteList;

/** 设置需要屏蔽的控制器*/
+ (void)LS_setBlackList:(NSArray<NSString *> *)list;
/** 默认导航栏的barTintColor*/
+ (void)LS_setDefaultNavigationBarBarTintColor:(UIColor *)barTintColor;

//// 默认导航栏的(作用有待测试)
//+ (void)LS_setDefaultNavigationBarBackgroundImage:(UIImage *)image;
/** 默认导航栏的tintColor*/
+ (void)LS_setDefaultNavigationBarTintColor:(UIColor *)tintColor;
/** 默认导航栏的titleColor*/
+ (void)LS_setDefaultNavigationBarTitleColor:(UIColor *)titleColor;
/** 默认状态栏的样式*/
+ (void)LS_setDefaultStatusBarStyle:(UIStatusBarStyle)style;
/** 默认ShadowImage的控制*/
+ (void)LS_setDefaultNavigationBarShadowImageHidden:(BOOL)hidden;

@end





#pragma mark - <UINavigationBar的分类>
@interface UINavigationBar (LSAddition)<UINavigationBarDelegate>

/** 导航栏所有barButtonItem的透明度*/
- (void)LS_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移的距离*/
- (void)LS_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少*/
- (CGFloat)LS_getTranslationY;

@end





#pragma mark - <UIViewController (LSExtension)>
@interface UIViewController (LSExtension)

/** 设置当前导航栏的BackgroundImage*/
// 已经弃用，使用LSCustomNavigationBar
- (void)LS_setNavigationBarBackgroundImage:(UIImage *)image;
/** 获取当前导航栏的BackgroundImage*/
// 该方法可以使用
- (UIImage *)LS_navigstionBarBackgroundImage;

/** 设置当前导航栏的barTintColor*/
- (void)LS_setNavigationBarBarTintColor:(UIColor *)barTintColor;
/** 获取当前导航栏的barTintColor*/
- (UIColor *)LS_navigationBarBarTintColor;

/** 设置当前导航栏的alpha*/
- (void)LS_setNavigationBarBackgroundAlpha:(CGFloat)alpha;
/** 获取当前导航栏的alpha*/
- (CGFloat)LS_navigationBarBackgroundAlpha;

/** 设置当前导航栏的tintColor*/
- (void)LS_setNavigationBarTintColor:(UIColor *)tintColor;
/** 获取当前导航栏的tintColor*/
- (UIColor *)LS_navigationBarTintColor;

/** 设置当前导航栏的titleColor*/
- (void)LS_setNavigationBarTitleColor:(UIColor *)titleColor;
/** 获取当前导航栏的titleColor*/
- (UIColor *)LS_navigationBarTitleColor;

/** 设置当前控制器的statusBarStyle*/
- (void)LS_setStatusBarStyle:(UIStatusBarStyle)style;
/** 获取当前控制器的statusBarStyle*/
- (UIStatusBarStyle)LS_statusBarStyle;

/** 设置当前导航栏的shadowImage的hidden*/
- (void)LS_setNavigationBarShadowImageHidden:(BOOL)hidden;
/** 获取当前导航栏的shadowImage的hidden*/
- (BOOL)LS_navigationShadowImageHidden;

@end

