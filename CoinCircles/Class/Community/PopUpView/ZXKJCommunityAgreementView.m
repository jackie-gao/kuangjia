//
//  ZXKJCommunityAgreementView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityAgreementView.h"

@interface ZXKJCommunityAgreementView ()
@property (weak, nonatomic) IBOutlet ZXKJCommunityAgreementView *contentView;
@property(nonatomic,copy) void(^agreeBlock)(void);
//@property(nonatomic,copy) NSString *urlString;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@end

@implementation ZXKJCommunityAgreementView

// 加载网页
+(instancetype)showInfoWithUrlString:(NSString *)urlString agreeBlock:(void (^)(void))agreeBlock
{
    ZXKJCommunityAgreementView *communityAgreementView = [self createCommunityAgreementView];
    communityAgreementView.agreeBlock = agreeBlock;
//    communityAgreementView.urlString = urlString;
    
    LSWebView *webView = [[LSWebView alloc]initWithFrame:communityAgreementView.contentView.bounds loadLocatHTML:urlString];
    webView.loadFinishBlock = ^{
        communityAgreementView.agreeButton.userInteractionEnabled = YES;
    };
    [communityAgreementView.contentView addSubview:webView];
    
    return communityAgreementView;
}

// 加载本地HTML
+ (instancetype)showInfoWithLoadHTML:(NSString *)fileName agreeBlock:(void (^)(void))agreeBlock
{
        ZXKJCommunityAgreementView *communityAgreementView = [self createCommunityAgreementView];
        communityAgreementView.agreeBlock = agreeBlock;
        
        LSWebView *webView = [[LSWebView alloc]initWithFrame:communityAgreementView.contentView.bounds loadLocatHTML:fileName];
        webView.loadFinishBlock = ^{
            communityAgreementView.agreeButton.userInteractionEnabled = YES;
        };
        [communityAgreementView.contentView addSubview:webView];
        
        return communityAgreementView;
}



#pragma mark - <action>
// 同意
- (IBAction)agreeButtonAction {
    [self setupHiddenAnimationWithCompleteBlock:nil];
}



#pragma mark - <method>
+ (ZXKJCommunityAgreementView *)createCommunityAgreementView
{
    ZXKJCommunityAgreementView *communityAgreementView = [ZXKJCommunityAgreementView viewFromNib];
    communityAgreementView.LS_width = kScreenWidth - 50;
    communityAgreementView.LS_height = kScreenHeight - 100;
    communityAgreementView.center = kKeyWindow.center;
    [kKeyWindow addSubview:communityAgreementView];
    // ios9、10必须调用该方法来适配
    [communityAgreementView layoutIfNeeded];
    // 将view的size缩小至无限小点
    communityAgreementView.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.3 animations:^{
        communityAgreementView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            communityAgreementView.transform = CGAffineTransformIdentity;
        }];
    }];
    
    return communityAgreementView;
}


/// 隐藏动画
- (void)setupHiddenAnimationWithCompleteBlock:(void(^)(void))completeBlock
{
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [LSCover dissmiss];
            
            !self.agreeBlock ? : self.agreeBlock();
            !completeBlock ? : completeBlock();
        }];
    }];
}

@end
