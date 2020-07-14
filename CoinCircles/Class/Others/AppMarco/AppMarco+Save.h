//
//  AppMarco+Save.h
//  blockchainKnowledge
//
//  Created by larson on 2019/8/13.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#ifndef AppMarco_Save_h
#define AppMarco_Save_h

// ============================== key ============================== //
// 个人信息
/// 手机号码
#define ZCKJMobileKey                   @"ZCKJMobile"
///  密码
#define ZCKJPasswordKey                 @"ZCKJPassword"
/// token
#define ZCKJTokenKey                    @"ZCKJToken"
/// 用户名
#define ZCKJNicknameKey                 @"ZCKJNickname"
/// 头像
#define ZCKJAvatarKey                   @"ZCKJAvatar"
/// 本地头像
#define ZCKJLocatAvatarKey              @"ZCKJLocatAvatar"
/// 邮件
#define ZCKJEmailKey                    @"ZCKJEmailKey"

// 圈子 CommunityAgreemen
/// 圈子协议
#define ZCKJCommunityAgreemenKey        @"ZCKJCommunityAgreemen"

/// 服务器版本
#define ZCKJServerVersionKey            @"ZCKJServerVersion"

/// 引导页版本
#define ZCKJGuidePageVersionKey         @"ZCKJGuidePageVersion"





// ============================== userDefaults ============================== //
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 保存
#define kUserDefaultsSetValueAndKey(value,key) \
{ \
[kUserDefaults setValue:value forKey:key];\
[kUserDefaults synchronize];\
}
// 重置
#define kUserDefaultsResetValueWithKey(key) \
{ \
[kUserDefaults removeObjectForKey:key]; \
}

// 保存bool值
#define kUserDefaultsSetBoolValueAndKey(value,key)  \
{ \
[kUserDefaults setBool:value forKey:key]; \
[kUserDefaults synchronize];\
}

// 取值
#define kUserDefaultsGetValueWithKey(key)             [kUserDefaults valueForKey:key]
#define kUserDefaultsGetStringWithKey(key)            [kUserDefaults stringForKey:key]
#define kUserDefaultsGetBoolWithKey(key)              [kUserDefaults boolForKey:key]
#define kUserDefaultsGetIntegerWithKey(key)           [kUserDefaults integerForKey:key]



// ============================== 沙盒 ============================== //
// 获取沙盒路径
#define kPathTemp NSTemporaryDirectory()
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 最近访问城市的归档数据
#define HPYXRecentSearchCitysFilePath [kPathCache stringByAppendingPathComponent:kRecentSearchCitysKey]
// 关键字的历史记录
#define HPYXSearchHistoryFilePath [kPathCache stringByAppendingPathComponent:kKeySearchHistoryKey]

#endif
