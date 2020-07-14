//
//  ZXKJHeadlinesDetailsModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/13.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJHeadlinesDetailsModel.h"

@implementation ZXKJHeadlinesDetailsModel

+ (instancetype)modelWithID:(NSInteger)ID imageNamed:(NSString *)imageNamed nickname:(NSString *)nickname time:(NSString *)time content:(NSString *)content
{
    ZXKJHeadlinesDetailsModel *model = [[self alloc]init];
    model.ID = ID;
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
