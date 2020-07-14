//
//  ZXKJMarketSectionHeaderView.h
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJMarketSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJMarketSectionHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong) ZXKJMarketSectionModel *sectionModel;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
