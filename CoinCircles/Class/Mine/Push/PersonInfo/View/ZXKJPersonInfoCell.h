//
//  ZXKJPersonInfoCell.h
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXKJPersonInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJPersonInfoCell : UITableViewCell
@property(nonatomic,strong) ZXKJPersonInfoModel *model;
// 修改头像
@property(nonatomic,copy) void(^avatrBlock)(UIImage *image);
// 修改昵称
@property(nonatomic,copy) void(^nickNameBlock)(NSString *nickName);
// 修改电子邮箱
@property(nonatomic,copy) void(^emailBlock)(NSString *email);

@end

NS_ASSUME_NONNULL_END
