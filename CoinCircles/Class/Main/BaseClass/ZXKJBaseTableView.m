//
//  ZXKJBaseTableView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJBaseTableView.h"

@implementation ZXKJBaseTableView

#pragma mark - <initialize>
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupBasic];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setupBasic];
    }
    return self;
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.backgroundColor = kClearColor;
    if (IS_LiuHai_Screen) {
        self.contentInset = kEdgeInsets(0, 0, -kHeightBottomSafe, 0);
    }
}

@end
