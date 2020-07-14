//
//  LSDataBase.h
//  CoinCircles
//
//  Created by Larson on 2020/7/11.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

// ----- FMDB操作工具 ----- //

#import <Foundation/Foundation.h>

@class ZXKJNewsModel,ZXKJCelebrityModel,ZXKJNewsDetailsModel,ZXKJHeadlinesDetailsModel;

NS_ASSUME_NONNULL_BEGIN

@interface LSDataBase : NSObject

/**
 * share instance
 */
+ (instancetype)sharedDataBase;



// ============================== 收藏 ============================== //
/**
 * 保存收藏数据
 *
 * @param model                   需要保存的模型
 */
- (void)insertCollectData:(ZXKJNewsModel *)model;

/**
 * 根据id删除收藏数据
 *
 * @param ID                          需要删除的id
 */
- (void)delectCollectDataWithID:(NSInteger)ID;

/**
 * 获取所有的收藏数据
 */
- (NSMutableArray *)getAllCollectData;



// ============================== 资讯评论 ============================== //
/**
 * 保存资讯评论数据
 *
 * @param model                   需要保存的模型
 */
- (void)insertNewsCommentData:(ZXKJNewsDetailsModel *)model;

/**
 * 根据id删除资讯评论数据
 *
 * @param time                      根据时间戳删除评论
 */
- (void)delectNewsCommentDataWithTime:(NSString *)time;

/**
 * 获取所有的资讯评论数据
 */
- (NSMutableArray *)getAllNewsCommentData;



// ============================== 头条资讯评论 ============================== //
/**
 * 保存资讯评论数据
 *
 * @param model                   需要保存的模型
 */
- (void)insertHeadlineCommentData:(ZXKJHeadlinesDetailsModel *)model;

/**
 * 根据id删除资讯评论数据
 *
 * @param ID                          需要删除的id
 */
- (void)delectHeadlineCommentDataWithID:(NSInteger)ID;

/**
 * 获取所有的资讯评论数据
 */
- (NSMutableArray *)getAllHeadlineCommentData;



// ============================== 名人榜 ============================== //
/**
 * 保存名人榜数据
 *
 * @param model                   需要保存的模型
 */
- (void)insertCelebrityData:(ZXKJCelebrityModel *)model;

/**
 * 根据id删除名人榜数据
 *
 * @param ID                          需要删除的id
 */
- (void)delectCelebrityDataWithID:(NSInteger)ID;

/**
 * 获取所有的名人榜数据
 */
- (NSMutableArray *)getAllCelebrityData;



// ============================== general ============================== //
/**
 * 查询某个数据是否存在
 *
 * @param tableName             表名
 * @param IDName                    id名
 * @param ID                             id
 */
- (BOOL)checkDataExistsWithTableName:(NSString *)tableName IDName:(NSString *)IDName ID:(NSInteger)ID;

@end

NS_ASSUME_NONNULL_END
