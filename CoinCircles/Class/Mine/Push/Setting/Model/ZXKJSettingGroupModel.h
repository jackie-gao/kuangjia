//
//  ZXKJSettingGroupModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXKJSettingModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJSettingGroupModel : NSObject
/** 存放模型的数组*/
@property(nonatomic,strong) NSArray<ZXKJSettingModel*> *groupModels;


+ (instancetype)groupModelWithModel:(NSArray *)models;

@end

NS_ASSUME_NONNULL_END
