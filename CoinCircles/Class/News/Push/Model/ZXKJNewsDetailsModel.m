//
//  ZXKJNewsDetailsModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsDetailsModel.h"

@implementation ZXKJNewsDetailsModel

+ (instancetype)modelWithImageNamed:(NSString *)imageNamed nickname:(NSString *)nickname time:(NSString *)time content:(NSString *)content
{
    ZXKJNewsDetailsModel *model = [[self alloc]init];
    model.imageNamed = [imageNamed copy];
    model.nickname = [nickname copy];
    model.time = [time copy];
    model.content = [content copy];
    
    return model;
}



- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight = [self.content getTextHeightWithViewWidth:kScreenWidth - 75 textFont:kFont(13)] + 80;
    }
    return _cellHeight;
}

@end
