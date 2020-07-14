//
//  ZXKJMarketSectionModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMarketSectionModel.h"
#import "ZXKJMarketModel.h"
#import "ZXKJRankingDetailsSectionModel.h"

@implementation ZXKJMarketSectionModel

- (void)setDetails:(NSArray *)details
{
    _details = [ZXKJMarketModel mj_objectArrayWithKeyValuesArray:details];
}


- (void)setMore:(NSArray *)more
{
    _more = [ZXKJRankingDetailsSectionModel mj_objectArrayWithKeyValuesArray:more];
}

@end
