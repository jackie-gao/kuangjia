//
//  ZXKJNewsModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsModel : NSObject
/** 主键id*/
@property(nonatomic,assign) NSInteger ID;
/** 编号*/
@property(nonatomic,strong) NSString *newsNo;
/** 标题*/
@property(nonatomic,strong) NSString *title;
/** 摘要*/
@property(nonatomic,strong) NSString *brief;
/** 内容*/
@property(nonatomic,strong) NSString *content;
/** 发布时间*/
@property(nonatomic,strong) NSString *gmtRelease;
/** 发布时间*/
@property(nonatomic,strong) NSString *strDayRelease;
/** 发布时分秒*/
@property(nonatomic,strong) NSString *strTimeRelease;
/** 是否有查看更多*/
@property(nonatomic,assign) BOOL hasMore;
/** 图片*/
@property(nonatomic,strong) NSString *coverUrl;
/** 来源*/
@property(nonatomic,strong) NSString *source;
/** 来源地址*/
@property(nonatomic,strong) NSString *sourceUrl;
/** 类型*/
@property(nonatomic,strong) NSString *type;


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
