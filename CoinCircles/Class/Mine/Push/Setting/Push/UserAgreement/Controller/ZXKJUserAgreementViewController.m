//
//  ZXKJUserAgreementViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJUserAgreementViewController.h"

@interface ZXKJUserAgreementViewController ()

@end

@implementation ZXKJUserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupBasic];
}



#pragma mark - <setup basic>
- (void)setupBasic
{
    self.customNavigationBar.title = @"用户协议";
        
    LSWebView *webView = [[LSWebView alloc]initWithFrame:kRect(0, kHeightNavigationBar, kScreenWidth, kScreenHeight - kHeightNavigationBar) urlString:ZCKJUserServeProtocolURL];
    [self.view addSubview:webView];
}

@end
