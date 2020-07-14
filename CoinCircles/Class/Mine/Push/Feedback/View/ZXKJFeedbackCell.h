//
//  ZXKJFeedbackCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJFeedbackCell : UITableViewCell
/** 提交意见*/
@property(nonatomic,copy) void(^submitBlock)(NSString *text);



/** 设置键盘*/
- (void)setupKeyboard;

/** 清空textView*/
- (void)emputTextView;

@end

NS_ASSUME_NONNULL_END
