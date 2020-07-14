//
//  LSNetworking.m
//  shanShuiHotel
//
//  Created by larson on 2019/2/19.
//  Copyright © 2019年 qingYunHotelInfo. All rights reserved.
//

#import "LSNetworking.h"
//#import <AFHTTPSessionManager.h>
#import <AFNetworking.h>

@interface LSNetworking ()
@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

//#import "LSLoginTool.h"
//#import "SSJDVerificationCodeLoginViewController.h"

#define LSNETWORKTIMEWORK  10   // 加载10s超时

@implementation LSNetworking

#pragma mark - <单例>
+ (instancetype)shareNetworkingTool
{
    static LSNetworking *_shareNetworkingTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareNetworkingTool = [[self alloc]init];
    });
    
    return _shareNetworkingTool;
}

- (instancetype)init
{
    if (self) {
        self.manager = AFHTTPSessionManager.manager;
        self.manager.requestSerializer.timeoutInterval = 10;
        self.manager.requestSerializer = AFJSONRequestSerializer.serializer;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                  @"application/json",
                                                                  @"text/json",
                                                                  @"text/javascript",
                                                                  @"text/plain",
                                                                  @"text/html",
                                                                  nil];
    }
    return self;
}



// =============== get请求 =============== //
#pragma mark - <get请求>
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id))success
    failure:(void (^)(id))failure
{
    [self.manager GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}



// =============== post请求 =============== //
#pragma mark - <没有token>
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
{
//    // 网络请求类
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy.validatesDomainName = NO;
//
//    URLString = [[NSString stringWithFormat:@"%@%@", XCKJServiceURL, URLString]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
////    NSLog(@"url - %@", URLString);
////    NSLog(@"param - %@", parameters);
//    [manager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject == nil ||
//            responseObject == [NSNull class]) {
//            [LSMaskTool showErrorMessage:@"获取数据失败"];
//            return;
//        }
//
//        success(responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        LSLog(@"error - %@", error.localizedDescription);
//        failure(error);
//    }];
}


#pragma mark - <有token>
- (void)POSTAccessToken:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//    URLString = [[NSString stringWithFormat:@"%@%@", XCKJServiceURL, URLString]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    parameters[@"token"] = kUserDefaultsGetValueWithKey(ZCKJTokenKey);
////    NSLog(@"url - %@", URLString);
////    NSLog(@"params - %@", parameters);
//    [[self request] POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                success(dict);
////                LSLog(@"dict - %@",dict);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
//        LSLog(@"state - %ld", httpResponse.statusCode);
//        // token失效
//        if (httpResponse.statusCode == 401) {
//            [LSMaskTool dismiss];
//            [LSSaveTool removeUserData];
//            UIViewController *vc = [self getCurrentViewController];
//            [vc.navigationController popViewControllerAnimated:YES];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [LSMaskTool showInfoMessage:@"登录失效，请重新登录"];
////                [LSLoginTool doLoginViewController];
//            });
//            return;
//        }
//        NSLog(@"error - %@", error.localizedDescription);
//        failure(error);
//        NSLog(@"全部的error - %@", error);
//    }];
}



//#pragma mark - <请求>
//- (AFHTTPSessionManager *)request
//{
//    NSLog(@"来这里");
//    static AFHTTPSessionManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.requestSerializer.timeoutInterval = 5;
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
//                                                             @"application/json",
//                                                             @"text/json",
//                                                             @"text/javascript",
//                                                             @"text/html",
//                                                             nil];
//
//
//
//
//
////        manager = [AFHTTPSessionManager manager];
////        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
////        manager.securityPolicy.allowInvalidCertificates = YES;
////        manager.securityPolicy.validatesDomainName = NO;
////        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
////                                                             @"application/json",
////                                                             @"text/html",
////                                                             @"image/jpeg",
////                                                             @"image/png",
////                                                             @"application/octet-stream",
////                                                             @"text/json",
////                                                             nil];
////        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    });
//
//    return manager;
//}

@end
