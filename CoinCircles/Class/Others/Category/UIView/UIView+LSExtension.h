//
//  UIView+LSExtension.h
//
//  Created by larson on 2016/1/1.
//  Copyright © 2016年 larson. All rights reserved.
//

// 用来快速获取frame属性
// 在分类中声明@property，只会生成方法的声明，不会生成的实现和带有_下划线的成员变量

#import <UIKit/UIKit.h>

@interface UIView (LSExtension)

/** x值*/
@property(nonatomic,assign) CGFloat LS_x;
/** y值*/
@property(nonatomic,assign) CGFloat LS_y;
/** 宽*/
@property(nonatomic,assign) CGFloat LS_width;
/** 高*/
@property(nonatomic,assign) CGFloat LS_height;
/** 大小*/
@property(nonatomic,assign) CGSize LS_size;
/** 中心点x*/
@property(nonatomic,assign) CGFloat LS_centerX;
/** 中心点y*/
@property(nonatomic,assign) CGFloat LS_centerY;
/** 最大x值*/
@property(nonatomic,assign) CGFloat LS_maxX;
/** 最大y值*/
@property(nonatomic,assign) CGFloat LS_maxY;



/** 快速创建xib控件*/
+ (instancetype)viewFromNib;

/**
 * xib嵌套xib时候，用来给嵌套的view绑定xib
 * xib的大小为view
 * 需要自己在xib的file's Owner中绑定
 * xib的Custom Class不需要绑定
 */
- (void)setupSelfNameXibOnSelf;

/** 判断一个控件是否真正显示在主窗口上*/
- (BOOL)isShowingOnKeyWindow;

/** 获得当前视图的容器控制器*/
- (UIViewController *)getCurrentViewForContainerController;

/**
 *  从父控件中获取需要获取的子控件(使用父控件来调用)
 *
 *  @param designationClass   需要从父控件中获取的子类
 */
- (instancetype)getDesignationView:(Class)designationClass;


/**
 *  绘制一条虚线
 *
 *  @param lineView       需要绘制虚线的view
 *  @param lineLength     虚线的宽度
 *  @param lineSpacing    虚线的间距
 *  @param lineColor      虚线的颜色
 *  @param isHorizonal    虚线的方向(YES：水平方向，NO：垂直方向)
 */
- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                       lineDirection:(BOOL)isHorizonal;

@end





