//
//  ZXKJSettingModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJSettingModel.h"

@implementation ZXKJSettingModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    ZXKJSettingModel *model = [[self alloc]init];
    model.title = dict[@"title"];
    model.isShowIndicator = [dict[@"isShowIndicator"] boolValue];
    model.detailsVC = dict[@"detailsVC"];
    
    return model;
}

@end
