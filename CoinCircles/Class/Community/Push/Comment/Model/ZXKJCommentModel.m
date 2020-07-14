//
//  ZXKJCommentModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommentModel.h"

@implementation ZXKJCommentModel

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        NSString *title = @"禁止发布一些令人反感，如色情、赌博、裸露和猥亵等等等内，发布的内容我们会在三个小时之内审核，通过审核之后才会在论坛中展示";
        CGFloat titleHeight = [title getTextHeightWithViewWidth:kScreenWidth - 10 * 2 textFont:kFont(12)];
        _cellHeight = titleHeight + (kScreenWidth - 15 * 2) / 3 + 398;
    }
    return _cellHeight;
}

@end
