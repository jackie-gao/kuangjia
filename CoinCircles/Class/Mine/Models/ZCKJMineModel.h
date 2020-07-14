//
//  ZCKJMineModel.h
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

// ----- 我的控制器的模型----- //

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCKJMineModel : NSObject
/** 图片名*/
@property(nonatomic,copy) NSString *imageNamed;
/** 标题*/
@property(nonatomic,copy) NSString *title;

/** 跳转*/
@property(nonatomic,assign) Class detailsVC;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
