//
//  LSProgressShapeLayer.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface LSProgressShapeLayer : CAShapeLayer
/**
 *  初始化
 *
 *  @frame     frame
 *
 *  @return    进度图层
 */
- (instancetype)initWithFrame:(CGRect)frame;

/** 开始进度动画*/
- (void)startProgressAnimation;
/** 停止进度动画*/
- (void)stopProgressAnimation;

@end
