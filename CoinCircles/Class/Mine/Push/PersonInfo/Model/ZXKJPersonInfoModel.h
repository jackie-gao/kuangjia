//
//  ZXKJPersonInfoModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJPersonInfoModel : NSObject
/** 头像*/
@property(nonatomic,copy) NSString *avatar;
/** 昵称*/
@property(nonatomic,copy) NSString *nickname;
/** 手机号码*/
@property(nonatomic,copy) NSString *mobile;
/** 电子邮箱*/
@property(nonatomic,copy) NSString *email;

@end

NS_ASSUME_NONNULL_END
