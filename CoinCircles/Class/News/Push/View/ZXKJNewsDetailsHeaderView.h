//
//  ZXKJNewsDetailsHeaderView.h
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsDetailsHeaderView : UIView
@property(nonatomic,copy) NSString *author;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) void (^contentHeightBlock)(CGFloat contentHeight);

@end

NS_ASSUME_NONNULL_END
