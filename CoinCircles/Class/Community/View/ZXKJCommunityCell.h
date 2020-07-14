//
//  ZXKJCommunityCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJCommunityModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCommunityCell : UITableViewCell
@property(nonatomic,strong) ZXKJCommunityModel *model;
// 屏蔽
@property(nonatomic,copy) void(^shieldBlock)(NSInteger index);
// 举报
@property(nonatomic,copy) void(^reportBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
