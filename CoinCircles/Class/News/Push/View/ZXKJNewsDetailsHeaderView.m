//
//  ZXKJNewsDetailsHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsDetailsHeaderView.h"
#import <WebKit/WebKit.h>

@interface ZXKJNewsDetailsHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) WKUserContentController *wkContent;

@end

@implementation ZXKJNewsDetailsHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}



#pragma mark - <setup>
- (void)setupBasic
{
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
    [self.wkWebView loadHTMLString:[headerString stringByAppendingString:self.content] baseURL:nil];
    [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:nil];
}



#pragma mark - <setter>
- (void)setContent:(NSString *)content
{
    _content = [content copy];
    
    [self setupBasic];
}

- (void)setAuthor:(NSString *)author
{
    _author = [author copy];
    
    self.authorLabel.text = author;
}

- (void)setTime:(NSString *)time
{
    _time = [time copy];
    
    self.timeLabel.text = time;
}



#pragma mark - <KVO>
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.wkWebView.LS_height = self.wkWebView.scrollView.contentSize.height;
    self.LS_height = self.wkWebView.scrollView.contentSize.height + 80;
    !self.contentHeightBlock ? : self.contentHeightBlock(self.LS_height);
    
}



#pragma mark - <lazy>
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]initWithFrame:kRect(0, 30, kScreenWidth, self.LS_height - 80) configuration:self.wkConfig];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
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
    }
    return _wkContent;
}



#pragma mark - <system method>
- (void)dealloc
{
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
