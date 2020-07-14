//
//  ZXKJCommunityModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityModel.h"

@implementation ZXKJCommunityModel

- (CGFloat)textHeight
{
    if (!_textHeight) {
        UIFont *font = kFont(14);
        CGFloat width = kScreenWidth - 15 * 2;
        _textHeight = [self.content getTextHeightWithViewWidth:width textFont:font];
        if (_textHeight > 55) _textHeight = 55;
    }
    return _textHeight;
}

- (CGFloat)imageHeight
{
    if (!_imageHeight) {
        _imageHeight = (kScreenWidth - 15 * 4) / 3;
    }
    return _imageHeight;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight = 49 + self.textHeight + 10 + self.imageHeight + 10 + 30 + 10;
    }
    return _cellHeight;
}

@end
