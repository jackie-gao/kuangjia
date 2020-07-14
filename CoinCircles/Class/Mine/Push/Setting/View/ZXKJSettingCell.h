//
//  ZXKJSettingCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJSettingModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJSettingCell : UITableViewCell
@property(nonatomic,strong) ZXKJSettingModel *model;
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
