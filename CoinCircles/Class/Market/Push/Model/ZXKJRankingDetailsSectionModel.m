//
//  ZXKJRankingDetailsSectionModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRankingDetailsSectionModel.h"
#import "ZXKJRankingDetailsModel.h"

@implementation ZXKJRankingDetailsSectionModel

- (void)setDetails:(NSArray *)details
{
    _details = [ZXKJRankingDetailsModel mj_objectArrayWithKeyValuesArray:details];
}

@end
