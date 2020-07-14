//
//  ZCKJMineModel.m
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZCKJMineModel.h"

@implementation ZCKJMineModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    ZCKJMineModel *model = [[self alloc]init];
    model.imageNamed = dict[@"imageNamed"];
    model.title = dict[@"title"];
    model.detailsVC = dict[@"detailsVC"];
    
    return model;
}

@end
