//
//  ZXKJSettingModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJSettingModel : NSObject
@property(nonatomic,strong) NSString *title;
/** 是否显示指示器*/
@property(nonatomic,assign) BOOL isShowIndicator;
/** 跳转*/
@property(nonatomic,assign) Class detailsVC;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
