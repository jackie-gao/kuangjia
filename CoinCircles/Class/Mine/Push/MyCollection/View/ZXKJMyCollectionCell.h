//
//  ZXKJMyCollectionCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJNewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJMyCollectionCell : UITableViewCell
@property(nonatomic,strong) ZXKJNewsModel *model;
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
