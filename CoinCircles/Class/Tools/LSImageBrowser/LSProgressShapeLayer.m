//
//  LSProgressShapeLayer.m
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSProgressShapeLayer.h"
#import <UIKit/UIKit.h>

@interface LSProgressShapeLayer ()
@property(nonatomic,strong) UIBezierPath *bezierPath;
@property(nonatomic,assign) BOOL isStartAnimation;

@end

@implementation LSProgressShapeLayer

#pragma mark - <初始化>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.frame = frame;
        [self setupBasic];
    }
    return self;
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.cornerRadius = self.frame.size.width / 2;
    self.fillColor = UIColor.clearColor.CGColor;
    self.strokeColor = UIColor.whiteColor.CGColor;
    self.lineWidth = 4;
    self.lineCap = kCALineCapRound;
    self.strokeStart = 0;
    self.strokeEnd = 0.01;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    
    self.path = self.bezierPath.CGPath;
    
    // app进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}



#pragma mark - <action>
#pragma mark <notioficationAction>
- (void)applicationDidBecomeActive:(NSNotification *)notiofication
{
    if (self.isStartAnimation) [self startProgressAnimation];
}



#pragma mark - <API>
/// 开始动画
- (void)startProgressAnimation
{
    self.isStartAnimation = YES;
    [self startAnimationWithAngle:M_PI];
}

/// 停止动画
- (void)stopProgressAnimation
{
    self.isStartAnimation = NO;
    [self removeAllAnimations];
}



#pragma mark - <method>
/// 开始动画的角度
- (void)startAnimationWithAngle:(CGFloat)angle
{
    self.strokeEnd = 0.4;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = @(angle);
    animation.duration = 0.4;
    // YES：从上一次动画结束的位置继续动画。NO：回到最开始的位置再次动画
    animation.cumulative = YES;
    animation.repeatCount = HUGE;
    [self addAnimation:animation forKey:nil];
}



#pragma mark - <lazy>
- (UIBezierPath *)bezierPath
{
    if (!_bezierPath) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, height / 2) radius:(width / 2 - 2) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    return _bezierPath;
}

@end
