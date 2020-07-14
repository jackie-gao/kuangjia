//
//  UIView+LSExtension.h
//
//  Created by larson on 2016/1/1.
//  Copyright © 2016年 larson. All rights reserved.
//

// 用来快速获取frame属性
// 在分类中声明@property，只会生成方法的声明，不会生成的实现和带有_下划线的成员变量

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic,assign) CGFloat LS_x;
@property(nonatomic,assign) CGFloat LS_y;
@property(nonatomic,assign) CGFloat LS_width;
@property(nonatomic,assign) CGFloat LS_height;
@property(nonatomic,assign) CGPoint LS_origin;
@property(nonatomic,assign) CGSize  LS_size;
@property(nonatomic,assign) CGFloat LS_centerX;
@property(nonatomic,assign) CGFloat LS_centerY;
@property(nonatomic,assign) CGFloat LS_maxX;
@property(nonatomic,assign) CGFloat LS_maxY;

@end





