//
//  LSSaveTool.m
//
//  Created by larson on 2016/10/27.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSSaveTool.h"
#import "SDImageCache.h"

@implementation LSSaveTool

#pragma mark - <用户信息>
// 保存用户数据
+ (void)saveUserDataWithDict:(NSDictionary *)dict
{
//    kUserDefaultsSetValueAndKey(dict[@"token"], ZCKJTokenKey)
//    kUserDefaultsSetValueAndKey(dict[@"mobile"], ZCKJMobileKey)
//    kUserDefaultsSetValueAndKey(dict[@"avatar"], ZCKJAvatarKey)
////    kUserDefaultsSetValueAndKey(dict[@"nickname"], ZCKJUsernameKey);
//    
//    // 登录成功
//    kPostNotification(ZXKJLoginSucceedKey);
}

// 删除用户数据
+ (void)removeUserData
{
    NSUserDefaults *userInfoData = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userInfoData dictionaryRepresentation];
    
    for (NSString *key in dict) {
        if (![key isEqualToString:ZCKJMobileKey]) {
            if (![key isEqualToString:ZCKJGuidePageVersionKey]) {
                if (![key isEqualToString:ZCKJServerVersionKey]) {
                    if (![key isEqualToString:ZCKJPasswordKey]) {
                        [userInfoData removeObjectForKey:key];
                        [userInfoData synchronize];
                    }
                }
            }
        }
    }
    
    // 退出登录
    kPostNotification(ZXKJLoginOutSucceedKey);
}



// --------------- 缓存数据 --------------- //
// 获取缓存的大小
+ (NSString *)getCacheSize
{
    NSInteger fileSize = [[SDImageCache sharedImageCache] totalDiskSize];
    
    return [self fileSizeWithInteger:fileSize];
}

// 清理缓存
+ (void)clearCache
{
    [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:nil];
}
    


#pragma mark - <计算文件的大小>
+ (NSString *)fileSizeWithInteger:(NSInteger)size
{
    // 1K = 1024dB, 1M = 1024K,1G = 1024M
    if (size < 1024) {// 小于1k
        if (size == 0) {
//            return [NSString stringWithFormat:@"%.1f", 0.0];
            return @"0.0M";
        }
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }
    else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size / 1024 / 1024;
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }
    else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }
    else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

@end
