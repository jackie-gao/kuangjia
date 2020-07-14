//
//  LSNetworking.h
//  shanShuiHotel
//
//  Created by larson on 2019/2/19.
//  Copyright © 2019年 qingYunHotelInfo. All rights reserved.
//

// 基于AFNetworking的封装

#import <Foundation/Foundation.h>

/** 二次封装的网络工具类实例*/
#define LSShareNetworkingTool [LSNetworking shareNetworkingTool]

@interface LSNetworking : NSObject

/** 二次分装的网络工具单例*/
+ (instancetype)shareNetworkingTool;


// =============== get请求 =============== //
/**
 *  get请求
 *
 *  @URLString    相对路径
 *  @parameters   请求参数
 *  @success      完成回调
 *  @failure      完成回调
 */
- (void)GET:(NSString *)URLString
        parameters:(id)parameters
        success:(void (^)(id responseObj))success
        failure:(void (^)(id error))failure;



// =============== post请求 =============== //
/**
 *  post请求(没有token)，用来登录
 *
 *  @URLString    相对路径
 *  @parameters   请求参数
 *  @success      完成回调
 *  @failure      完成回调
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 *  post请求(有token)
 *
 *  @URLString    相对路径
 *  @parameters   请求参数
 *  @success      完成回调
 *  @failure      完成回调
 */
- (void)POSTAccessToken:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

@end
