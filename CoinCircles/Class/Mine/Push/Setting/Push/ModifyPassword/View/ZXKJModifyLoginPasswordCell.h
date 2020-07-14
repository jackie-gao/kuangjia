//
//  ZXKJModifyLoginPasswordCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJModifyLoginPasswordCell : UITableViewCell
/** 更换密码*/
@property(nonatomic,copy) void(^modifyLoginPasswordBlock)(NSString *oldPassword, NSString *novelPassword);



/// 键盘设置
- (void)setupKeyboard;

@end

NS_ASSUME_NONNULL_END
