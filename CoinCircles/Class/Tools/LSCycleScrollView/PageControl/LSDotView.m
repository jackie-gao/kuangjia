//
//  LSDotView.m
//  collectionView轮播图
//
//  Created by larson on 2019/2/25.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSDotView.h"

@implementation LSDotView

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



#pragma mark - <基本设置>
- (void)setup
{
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 2;
}



#pragma mark - <method>
// 改变活动状态
- (void)changeActivityState:(BOOL)active
{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
