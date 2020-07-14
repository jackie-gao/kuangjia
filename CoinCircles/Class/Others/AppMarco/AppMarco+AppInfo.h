//
//  AppMarco+AppInfo.h
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#ifndef AppMarco_AppInfo_h
#define AppMarco_AppInfo_h

// ============================== AppInfo ============================== //
#define kAppBundleInfoDict                  [[NSBundle mainBundle] infoDictionary]
#define kAppName                            [kAppBundleInfoDict objectForKey:@"CFBundleDisplayName"]
#define kAppBunldID                         [kAppBundleInfoDict objectForKey:@"CFBundleIdentifier"]
#define kAppReleaseVersion                  [kAppBundleInfoDict objectForKey:@"CFBundleShortVersionString"]
#define kAppDevelopVersion                  [kAppBundleInfoDict objectForKey:(NSString *)kCFBundleVersionKey]
#define kAppVersionCode                     ([kAppReleaseVersion stringByReplacingOccurrencesOfString:@"." withString:@""])
#define kCurrentLanguage                    ([[NSLocale preferredLanguages] objectAtIndex:0])



// ============================== 提示用户开启权限 ============================== //
// 获取相机权限
#define ZCKJGetCameraPermissions           @"无法获取您的相机权限。\n请到手机系统的[设置]->[隐私]->[相机]中允许山水酒店使用相机服务"
// 获取相册权限
#define ZCKJGetPhotoPermissions            @"无法获取您的相机权限。\n请到手机系统的[设置]->[隐私]->[相机]中允许山水酒店使用相机服务"

#endif /* AppMarco_AppInfo_h */
