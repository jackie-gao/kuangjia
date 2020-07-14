//
//  ZXKJCelebrityDetailsViewController.h
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

// ----- 圈子 - 名人榜 - 名人介绍的控制器 ----- //

#import "ZXKJBaseViewController.h"

@class ZXKJCelebrityModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCelebrityDetailsViewController : ZXKJBaseViewController
@property(nonatomic,strong) ZXKJCelebrityModel *model;
/** 取消关注*/
@property(nonatomic,copy) void(^cancelAttentionBlock)(void);

@end

NS_ASSUME_NONNULL_END
