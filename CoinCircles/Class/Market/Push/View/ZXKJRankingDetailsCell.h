//
//  ZXKJRankingDetailsCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJRankingDetailsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJRankingDetailsCell : UITableViewCell
@property(nonatomic,strong) ZXKJRankingDetailsModel *model;
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
