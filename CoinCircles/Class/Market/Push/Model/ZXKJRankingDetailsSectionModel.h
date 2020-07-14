//
//  ZXKJRankingDetailsSectionModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJRankingDetailsSectionModel : NSObject
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *index;
@property(nonatomic,copy) NSString *change;
@property(nonatomic,strong) NSArray *details;

@end

NS_ASSUME_NONNULL_END
