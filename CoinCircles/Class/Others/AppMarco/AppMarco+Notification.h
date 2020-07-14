//
//  AppMarco+Notification.h
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#ifndef AppMarco_Notification_h
#define AppMarco_Notification_h

// ============================== 登录注册 ============================== //
// 注册
/// 注册成功
#define ZXKJRegisterSucceedKey                     @"ZXKJRegisterSucceed"

// 登录
/// 登录成功
#define ZXKJLoginSucceedKey                        @"ZXKJLoginSucceed"
/// 退出登录
#define ZXKJLoginOutSucceedKey                     @"ZXKJLoginOutSucceed"
/// 更新信息
#define ZXKJUpdateInfoKey                          @"ZXKJUpdateInfo"



// ============================== 通知操作 ============================== //
#define kNotificationCenter     [NSNotificationCenter defaultCenter]
/// 发送通知
#define kPostNotification(notification) [kNotificationCenter postNotificationName:notification object:nil]
#define kPostNotificationWithObject(notification, anObject) [kNotificationCenter postNotificationName:notification object:anObject]
#define kPostNotificationWithObjectAndUserInfo(notification, anObject, aUserInfo) [kNotificationCenter postNotificationName:notification object:anObject userInfo:aUserInfo]
// 监听通知
#define kAddNotificationWithSelectorAndName(observer, aSelector, notification) [kNotificationCenter addObserver:observer selector:@selector(aSelector) name:notification object:nil]
#define kAddNotificationWithSelectorAndNameAndObject(observer, aSelector, notification, anObject) [kNotificationCenter addObserver:observer selector:@selector(aSelector) name:notification object:anObject]
// 移除通知
#define kRemoveNotification(observer) [[NSNotificationCenter defaultCenter] removeObserver:observer]
#define kRemoveNotificationWithName(observer, notification) [kNotificationCenter removeObserver:observer name:notification object:nil]
#define kRemoveNotificationWithNameAndObject(observer, notification, anObject) [kNotificationCenter removeObserver:observer name:notification object:anObject]

#endif /* AppMarco_Notification_h */
