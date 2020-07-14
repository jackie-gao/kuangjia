//
//  ZXKJCelebrityModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCelebrityModel : NSObject
@property(nonatomic,assign) NSInteger ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *image;
/** 前言*/
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;



/**
 *  获取网络数据
 *
 *  @param params      需要传递的参数
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
+ (void)loadDataWithParams:(NSMutableDictionary *)params
                   success:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
