//
//  LSLoginTool.h
//  WLChannel
//
//  Created by larson on 2016/4/9.
//  Copyright © 2016年 larson. All rights reserved.
//

// 用来登录的工具类

#import <Foundation/Foundation.h>

@interface LSLoginTool : NSObject

/**
 *  注册
 *
 *  @params
 *  @success      完成回调
 *  @failure      失败回调
 */
+ (void)registerUserWithParams:(NSMutableDictionary *)params
                       success:(void (^)(id result))success
                       failure:(void (^)(NSError *error))failure;


/**
 *  登录
 *
 *  @urlString    路径
 *  @params
 *  @success      完成回调
 *  @failure      失败回调
 */
+ (void)loginWithURL:(NSString *)urlString
              params:(NSMutableDictionary *)params
                success:(void (^)(id result))success
                failure:(void (^)(NSError *error))failure;



/**
 *  获取验证码
 *
 *  @urlString    路径
 *  @params
 *  @success      完成回调
 *  @failure      失败回调
 */
+ (void)getVerificationCodeWithURL:(NSString *)urlString
                            params:(NSMutableDictionary *)params
                           success:(void (^)(id result))success
                           failure:(void (^)(NSError *error))failure;


/**
 *  重置密码
 *
 *  @urlString    路径
 *  @params
 *  @success      完成回调
 *  @failure      失败回调
 */
+ (void)resetPasswordWithURL:(NSString *)urlString
                      params:(NSMutableDictionary *)params
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure;


/**
 *  退出登录
 *
 *  @urlString    路径
 *  @params
 *  @success      完成回调
 *  @failure      失败回调
 */
+ (void)loginOutWithParams:(NSMutableDictionary *)params
                   success:(void (^)(id result))success
                   failure:(void (^)(NSError *error))failure;





/** 检测是否登录*/
+ (BOOL)checkLoginState;

/** 进入登录控制器*/
+ (void)doLoginViewController;

/** 倒计时*/
+ (void)openCountdown:(UIButton *)button;

@end
