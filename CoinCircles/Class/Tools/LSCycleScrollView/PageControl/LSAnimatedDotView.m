//
//  LSAnimatedDotView.m
//  collectionView轮播图
//
//  Created by larson on 2019/2/25.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation LSAnimatedDotView

#pragma mark - <初始化>
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}



#pragma mark - <初始化设置>
- (void)setup
{
    self.dotColor = UIColor.whiteColor;
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 2;
}



#pragma mark - <setter>
- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.layer.borderColor = dotColor.CGColor;
}



#pragma mark - <method>
// 改变活动状态
- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    }else {
        [self animateToDeactiveState];
    }
}

// 活动状态部动画
- (void)animateToActiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = self.dotColor;
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:nil];
}

// 不活动状态动画
- (void)animateToDeactiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
