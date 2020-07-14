//
//  ZXKJCommentCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJCommentModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCommentCell : UITableViewCell
@property(nonatomic,copy) void(^releaseBlock)(ZXKJCommentModel *model);

/** 设置键盘*/
- (void)setupKeyboard;

@end

NS_ASSUME_NONNULL_END
