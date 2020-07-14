//
//  LSWebView.m
//  shanShuiHotel
//
//  Created by larson on 2019/6/17.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "LSWebView.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"

@interface LSWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) WKUserContentController *wkContent;
@property(nonatomic,strong) WeakScriptMessageDelegate *scriptMessageDelegate;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation LSWebView

#pragma mark - <initialize>
- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBaisc];
        NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
        [self.wkWebView loadRequest:requset];
        // 进度条
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame loadHTMLString:(NSString *)string
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBaisc];
        [self.wkWebView loadHTMLString:string baseURL:nil];
        // 进度条
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame loadLocatHTML:(NSString *)fileName
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBaisc];
        
        NSURLRequest *requset = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:fileName withExtension:nil]];
        [self.wkWebView loadRequest:requset];
        // 进度条
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}



#pragma mark - <setup>
- (void)setupBaisc
{
    // 清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}



#pragma mark - <setter>
- (void)setCallCustomerServiceID:(NSString *)callCustomerServiceID
{
    _callCustomerServiceID = [callCustomerServiceID copy];
    
    [self.wkContent addScriptMessageHandler:self.scriptMessageDelegate name:callCustomerServiceID];
}



#pragma mark - <KVO>
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.wkWebView) {
        self.progressView.hidden = NO;
        self.progressView.alpha = 1.0f;
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
                self.progressView.hidden = YES;
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



#pragma mark - <delegate>
#pragma mark <WKNavigationDelegate>
// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.progressTintColor) {
        self.progressView.tintColor = self.progressTintColor;
    }
    self.progressView.hidden = NO;
    // 防止progressView被网页挡住
    [self bringSubviewToFront:self.progressView];
}

// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [LSMaskTool dismiss];
    
    !self.loadFinishBlock ? : self.loadFinishBlock();
    if ([self.webDelegate respondsToSelector:@selector(webViewDidFinishload:)]) {
        [self.webDelegate webViewDidFinishload:self];
    }
}

// 加载失败
 - (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.progressView.progress = 0.0;
    // 加载失败需要隐藏progressView
    self.progressView.hidden = YES;
}

// 页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark <WKScriptMessageHandler>
// js调用OC
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:self.callCustomerServiceID]) {
        if ([self.webDelegate respondsToSelector:@selector(webView:callCustomerService:)]) {
            [self.webDelegate webView:self callCustomerService:message.body];
        }
    }
}




#pragma mark - <lazy>
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]initWithFrame:self.bounds configuration:self.wkConfig];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (WKWebViewConfiguration *)wkConfig
{
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc]init];
        _wkConfig.userContentController = self.wkContent;
        _wkConfig.allowsInlineMediaPlayback = YES;
    }
    return _wkConfig;
}

- (WKUserContentController *)wkContent
{
    if (!_wkContent) {
        _wkContent = [[WKUserContentController alloc]init];
        _scriptMessageDelegate = [[WeakScriptMessageDelegate alloc]initWithDelegate:self];
    }
    return _wkContent;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = kRect(0, 0, self.LS_width, 5);
        _progressView.tintColor = kTintColor;
        _progressView.trackTintColor = kClearColor;
        [self addSubview:self.progressView];
    }
    return _progressView;
}



#pragma mark - <systemMethod>
- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkContent removeScriptMessageHandlerForName:self.callCustomerServiceID];
}

@end
