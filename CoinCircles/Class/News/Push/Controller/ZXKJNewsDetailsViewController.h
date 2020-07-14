//
//  ZXKJNewsDetailsViewController.h
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJBaseViewController.h"

@class ZXKJNewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsDetailsViewController : ZXKJBaseViewController
@property(nonatomic,strong) ZXKJNewsModel *model;
@property(nonatomic,copy) void(^cancelCollectBlock)(void);

@end

NS_ASSUME_NONNULL_END
