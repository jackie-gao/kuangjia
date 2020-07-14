//
//  ZXKJNewsModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsModel.h"

@implementation ZXKJNewsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}



+ (void)loadDataWithParams:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSShareNetworkingTool GET:ZCKJBaseURL parameters:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(id error) {
        failure(error);
    }];
}

@end
