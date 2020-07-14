//
//  ZCKJMineGroupModel.m
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZCKJMineGroupModel.h"

@implementation ZCKJMineGroupModel

+ (instancetype)groupModelWithModel:(NSArray *)models
{
    ZCKJMineGroupModel *groupModel = [[self alloc]init];
    groupModel.groupModels = models;
    
    return groupModel;
}

@end
