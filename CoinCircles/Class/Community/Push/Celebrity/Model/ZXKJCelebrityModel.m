//
//  ZXKJCelebrityModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCelebrityModel.h"

@implementation ZXKJCelebrityModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}



+ (void)loadDataWithParams:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSShareNetworkingTool GET:ZCKJCelebrityURL parameters:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(id error) {
        failure(error);
    }];
}

@end
