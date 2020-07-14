//
//  ZXKJMarketSectionModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXKJRankingDetailsSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJMarketSectionModel : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *index;
@property(nonatomic,copy) NSString *change;
@property(nonatomic,strong) NSArray *details;
@property(nonatomic,strong) NSArray *more;


@end

NS_ASSUME_NONNULL_END
