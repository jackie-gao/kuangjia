//
//  ZXKJMarketCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJMarketModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJMarketCell : UITableViewCell
@property(nonatomic,strong) ZXKJMarketModel *model;
/** separator line*/
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
