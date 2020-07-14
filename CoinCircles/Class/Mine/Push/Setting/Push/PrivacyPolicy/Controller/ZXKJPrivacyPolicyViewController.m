//
//  ZXKJPrivacyPolicyViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJPrivacyPolicyViewController.h"

@interface ZXKJPrivacyPolicyViewController ()

@end

@implementation ZXKJPrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}



#pragma mark - <setup basic>
- (void)setupBasic
{
    self.customNavigationBar.title = @"隐私政策";
        
    LSWebView *webView = [[LSWebView alloc]initWithFrame:kRect(0, kHeightNavigationBar, kScreenWidth, kScreenHeight - kHeightNavigationBar) loadLocatHTML:@"privacyPolicy.html"];
    [self.view addSubview:webView];
}

@end
