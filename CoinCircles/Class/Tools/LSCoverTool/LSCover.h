//
//  LSCover.h
//  larson
//
//  Created by larson on 2016/10/16.
//  Copyright © 2016年 larson. All rights reserved.
//

// ----- 蒙版 ------ //
/**
 * 展示到指定的界面上，需要手动销毁控件
 */

#import <UIKit/UIKit.h>

@interface LSCover : UIView

/**
 展示到keyWindow上
 @param dissmissBlock 点击蒙版可以让蒙版消失
*/
+ (void)showWithDissmissBlock:(void(^)(void))dissmissBlock;


/**
 展示到指定的view的类方法
 @param  superView       需要展示蒙版的父控件
 @param positioningView  用来定位蒙版展示在superView的index
 @param dissmissBlock    点击蒙版可以让蒙版消失
 */
+ (instancetype)showInView:(UIView *)superView
           positioningView:(UIView *)positioningView
              dismissBlock:(void(^)(void))dissmissBlock;


/** 隐藏蒙版*/
+ (void)dissmiss;
- (void)dissmiss;

@end
