//
//  ZXKJHeadlinesDetailsCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/13.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJHeadlinesDetailsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJHeadlinesDetailsCell : UITableViewCell
@property(nonatomic,strong) ZXKJHeadlinesDetailsModel *model;
/** 删除评论*/
@property(nonatomic,copy) void(^deleteCommentBlock)(NSInteger index);
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
