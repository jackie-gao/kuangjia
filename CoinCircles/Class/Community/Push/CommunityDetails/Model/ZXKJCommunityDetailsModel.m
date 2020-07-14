//
//  ZXKJCommunityDetailsModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityDetailsModel.h"

@implementation ZXKJCommunityDetailsModel

+ (instancetype)modelWithUsername:(NSString *)username content:(NSString *)content time:(NSString *)time
{
    ZXKJCommunityDetailsModel *model = [[self alloc]init];
    model.username = [username copy];
    model.username = [content copy];
    model.username = [time copy];
    
    return model;
}

@end
