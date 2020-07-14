//
//  LSLoginTool.m
//  WLChannel
//
//  Created by larson on 2016/4/9.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSLoginTool.h"
#import "ZXKJTabBarController.h"
#import "ZXKJNavigationController.h"
#import "ZXKJLoginViewController.h"

@implementation LSLoginTool

#pragma mark - <注册>
+ (void)registerUserWithParams:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSShareNetworkingTool POST:@"" parameters:params success:^(id responseObject) {

        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);
    }];
}



#pragma mark - <登录>
+(void)loginWithURL:(NSString *)urlString params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSMaskTool showLoadWithMaskAndMessage:@"登录中..."];
    [LSShareNetworkingTool POST:urlString parameters:params success:^(id responseObject) {
        success(responseObject);
        [LSMaskTool dismiss];
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [LSMaskTool showErrorMessage:responseObject[@"msg"]];
            return;
        }
        
        [LSMaskTool showSucceessMessage:responseObject[@"msg"]];
//        [LSSaveTool saveUserDataWithDict:responseObject[@"data"][@"userinfo"]];
        
        // 登录成功退出登录控制器
        UIViewController *rootVC = [UIApplication sharedApplication].windows.firstObject.rootViewController;
        [rootVC.view endEditing:YES];
        [rootVC dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [LSMaskTool dismiss];
        failure(error);
    }];
}



#pragma mark - <获取验证码>
+ (void)getVerificationCodeWithURL:(NSString *)urlString params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSMaskTool showLoadWithMaskAndMessage:@"正在获取验证码..."];
    [LSShareNetworkingTool POST:urlString parameters:params success:^(id responseObject) {
        [LSMaskTool dismiss];
//        LSLog(@"获取验证码 - %@", responseObject);
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [LSMaskTool showErrorMessage:responseObject[@"msg"]];
            return;
        }

        success(responseObject);
        [LSMaskTool showSucceessMessage:responseObject[@"msg"]];
        
    } failure:^(NSError *error) {
        [LSMaskTool dismiss];
        failure(error);
    }];
}



#pragma mark - <重置密码>
+ (void)resetPasswordWithURL:(NSString *)urlString params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSMaskTool showLoadWithMaskAndMessage:@"重置密码中..."];
    [LSShareNetworkingTool POST:urlString parameters:params success:^(id responseObject) {
        [LSMaskTool dismiss];
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [LSMaskTool showErrorMessage:responseObject[@"msg"]];
            return;
        }
        
        [LSMaskTool showSucceessMessage:responseObject[@"msg"]];
        success(responseObject);
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark - <退出登录>
+ (void)loginOutWithParams:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSMaskTool showLoadWithMeaasge:@"退出登录中..."];
    [LSShareNetworkingTool POSTAccessToken:@"" parameters:params success:^(id responseObject) {
        [LSMaskTool dismiss];
//        LSLog(@"退出登录 - %@", responseObject);
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [LSMaskTool showErrorMessage:responseObject[@"msg"]];
            return;
        }
        
        [LSMaskTool showSucceessMessage:responseObject[@"msg"]];
        [LSSaveTool removeUserData];
        !success ? : success(responseObject);
        
    } failure:^(NSError *error) {
        [LSMaskTool dismiss];
        LSLog(@"退出登录error - %@", error);
        !failure ? : failure(error);
    }];
}



#pragma mark - <检测是否登录>
+ (BOOL)checkLoginState
{
    return kUserDefaultsGetValueWithKey(ZCKJTokenKey) == nil ? NO : YES;
}



#pragma mark - <进入登录控制器>
+ (void)doLoginViewController
{
    UIViewController *rootVC = kKeyWindow.rootViewController;
    ZXKJLoginViewController *loginVC = [[ZXKJLoginViewController alloc]init];
    ZXKJNavigationController *navVC = [[ZXKJNavigationController alloc]initWithRootViewController:loginVC];
    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootVC presentViewController:navVC animated:YES completion:nil];
}



#pragma mark - <倒计时>
+ (void)openCountdown:(UIButton *)button
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = YES;
                [button setTitleColor:[UIColor colorWithRed:3 / 255.0 green:207 / 255.0 blue:184 / 255.0 alpha:1] forState:UIControlStateNormal];
                //设置按钮的样式
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = NO;
                [button setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                //设置按钮显示读秒效果
                [button setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



@end





