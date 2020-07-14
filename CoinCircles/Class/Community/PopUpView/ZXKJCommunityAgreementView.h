//
//  ZXKJCommunityAgreementView.h
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

// ---------- 圈子协议 ---------- //

#import <UIKit/UIKit.h>

@interface ZXKJCommunityAgreementView : UIView

/**
 * 展示圈子协议
 * param urlString                     协议地址
 * param agreeBlock                点击同意
 *
 * @return              协议提示view
 */
+ (instancetype)showInfoWithUrlString:(NSString *)urlString
                           agreeBlock:(void(^)(void))agreeBlock;

/**
 * 展示圈子协议
 * param fileName                     HTML文件名
 * param agreeBlock                 点击同意
 *
 * @return              协议提示view
 */
+ (instancetype)showInfoWithLoadHTML:(NSString *)fileName
                          agreeBlock:(void(^)(void))agreeBlock;

@end
