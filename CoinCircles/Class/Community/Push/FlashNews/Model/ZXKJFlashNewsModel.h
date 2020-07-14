//
//  ZXKJFlashNewsModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJFlashNewsModel : NSObject
@property(nonatomic,copy) NSString *gmtRelease;
@property(nonatomic,copy) NSString *content;


@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,assign) BOOL isHideTopLine;


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
