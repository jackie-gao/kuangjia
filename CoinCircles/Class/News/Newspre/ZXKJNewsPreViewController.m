//
//  ZXKJNewsPreViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/13.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsPreViewController.h"
#import <WebKit/WebKit.h>

@interface ZXKJNewsPreViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ZXKJNewsPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}



#pragma mark - <instance>
- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.webView];
}



#pragma mark - <UIWebViewDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [LSMaskTool showLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [LSMaskTool dismiss];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
}



#pragma mark - <lazy>
- (WKWebView *)webView
{
    if (!_webView) {
        _webView= [[WKWebView alloc] init];
        _webView.backgroundColor = UIColor.whiteColor;
        _webView.frame = CGRectMake(0, kHeightStatusBar, kScreenWidth, kScreenHeight - kHeightStatusBar - kHeightBottomSafe);
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.UIDelegate = self;
        // 支持滑动返回
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

@end
