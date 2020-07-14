//
//  ZCKJMineGroupModel.h
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZCKJMineModel;

@interface ZCKJMineGroupModel : NSObject
/** 存放模型的数组*/
@property(nonatomic,strong) NSArray<ZCKJMineModel*> *groupModels;


+ (instancetype)groupModelWithModel:(NSArray *)models;

@end

NS_ASSUME_NONNULL_END
