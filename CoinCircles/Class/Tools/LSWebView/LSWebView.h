//
//  LSWebView.h
//  shanShuiHotel
//
//  Created by larson on 2019/6/17.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

// --------------- 基于WKWebView自定义的webView --------------- //

#import <UIKit/UIKit.h>

@class LSWebView;

@protocol LSWebViewDelegate <NSObject>

@optional
/** 拨打客服电话*/
- (void)webView:(LSWebView *)webView callCustomerService:(NSString *)serviceTel;

/** 加载完成*/
- (void)webViewDidFinishload:(LSWebView *)webView;

@end

@interface LSWebView : UIView
/** progress颜色*/
@property(nonatomic,strong) UIColor *progressTintColor;
// JS调用OC注册的方法名
/** 拨打客服电话*/
@property(nonatomic,copy) NSString *callCustomerServiceID;
/** 加载完成*/
@property(nonatomic,copy) void(^loadFinishBlock)(void);
/** LSWebView代理*/
@property(nonatomic,weak) id<LSWebViewDelegate> webDelegate;


/**
 * 加载网页
 *
 * @param frame                             webView的frame
 * @param urlString                     webView的url
 *
 * @return                   webView
 */
- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

/**
 * 加载HTML字符串
 *
 * @param frame                             webView的frame
 * @param string                           本地HTML
 *
 * @return                   webView
 */
- (instancetype)initWithFrame:(CGRect)frame loadHTMLString:(NSString *)string;

/**
 * 加载本地HTML
 *
 * @param frame                             webView的frame
 * @param fileName                       HTML文件名
 *
 * @return                   webView
 */
- (instancetype)initWithFrame:(CGRect)frame loadLocatHTML:(NSString *)fileName;

@end
