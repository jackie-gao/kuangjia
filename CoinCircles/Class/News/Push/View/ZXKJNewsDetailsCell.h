//
//  ZXKJNewsDetailsCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJNewsDetailsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsDetailsCell : UITableViewCell
@property(nonatomic,strong) ZXKJNewsDetailsModel *model;
/** 删除评论*/
@property(nonatomic,copy) void(^deleteCommentBlock)(NSInteger index);
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
