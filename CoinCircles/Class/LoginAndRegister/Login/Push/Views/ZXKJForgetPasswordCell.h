//
//  ZXKJForgetPasswordCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJForgetPasswordCell : UITableViewCell
/** 重置密码*/
@property(nonatomic,copy) void(^resetPasswordBlock)(NSString *phonenum, NSString *neoPasswordStr);



/// 键盘设置
- (void)setupKeyboard;

@end

NS_ASSUME_NONNULL_END
