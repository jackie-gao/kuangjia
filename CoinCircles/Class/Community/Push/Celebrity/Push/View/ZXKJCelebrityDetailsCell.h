//
//  ZXKJCelebrityDetailsCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJCelebrityModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCelebrityDetailsCell : UITableViewCell
@property(nonatomic,strong) ZXKJCelebrityModel *model;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,assign) CGFloat imageHeight;

@end

NS_ASSUME_NONNULL_END
