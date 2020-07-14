//
//  ZXKJMineHeaderViewModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJMineHeaderViewModel : NSObject
/** 头像*/
@property(nonatomic,copy) NSString *avatar;
/** 手机号*/
@property(nonatomic,copy) NSString *mobile;
/** 昵称*/
@property(nonatomic,copy) NSString *nickname;



+ (instancetype)modelWithAvatar:(NSString *)avatar mobile:(NSString *)mobile nickname:(NSString *)nickname;

@end

NS_ASSUME_NONNULL_END
