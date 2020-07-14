//
//  ZXKJEmptyView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJEmptyView.h"

@implementation ZXKJEmptyView

- (void)prepare
{
    [super prepare];
    
    self.autoShowEmptyView = NO;
    
    self.detailsLabeFont = kFont(13);
    self.detailsLabelTextColor = kHomochromyColor(153);
    
}

@end
