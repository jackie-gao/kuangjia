//
//  ZXKJLoginCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJLoginCell : UITableViewCell
@property(nonatomic,strong) NSString *phoneNum;
/** 登录*/
@property(nonatomic,copy) void(^loginBlock)(NSString *phoneNum, NSString *password);



/// 设置键盘
- (void)setupKeyboard;

@end

NS_ASSUME_NONNULL_END
