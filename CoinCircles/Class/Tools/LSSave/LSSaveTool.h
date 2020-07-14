//
//  LSSaveTool.h
//
//  Created by larson on 2016/10/27.
//  Copyright © 2016年 larson. All rights reserved.
//

// --------------- 存储的工具类 --------------- //

#import <Foundation/Foundation.h>

@interface LSSaveTool : NSObject
// -------------------- 用户信息 -------------------- //
/// 保存用户的信息
+ (void)saveUserDataWithDict:(NSDictionary *)dict;

/// 删除用户数据
+ (void)removeUserData;



// --------------- 缓存数据 --------------- //
/// 获取缓存数据的大小
+ (NSString *)getCacheSize;

/// 清理缓存
+ (void)clearCache;

@end
