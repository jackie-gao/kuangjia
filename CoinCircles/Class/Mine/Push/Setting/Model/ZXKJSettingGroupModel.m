//
//  ZXKJSettingGroupModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJSettingGroupModel.h"

@implementation ZXKJSettingGroupModel

+ (instancetype)groupModelWithModel:(NSArray *)models
{
    ZXKJSettingGroupModel *groupModel = [[self alloc]init];
    groupModel.groupModels = models;
    
    return groupModel;
}

@end
