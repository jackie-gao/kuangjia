//
//  ZXKJRegisterCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJRegisterCell : UITableViewCell
/** 注册*/
@property(nonatomic,copy) void(^registerBlock)(NSString *phoneNumStr, NSString *inviteCodeStr, NSString *passwordStr);


/// 设置键盘
- (void)setupKeyboard;

@end

NS_ASSUME_NONNULL_END
