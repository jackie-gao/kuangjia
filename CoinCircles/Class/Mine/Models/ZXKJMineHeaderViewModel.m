//
//  ZXKJMineHeaderViewModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMineHeaderViewModel.h"

@implementation ZXKJMineHeaderViewModel

+ (instancetype)modelWithAvatar:(NSString *)avatar mobile:(NSString *)mobile nickname:(NSString *)nickname
{
    ZXKJMineHeaderViewModel *model = [[self alloc]init];
    model.avatar = [avatar copy];
    model.mobile = [mobile copy];
    model.nickname = [nickname copy];
    
    return model;
}

@end
