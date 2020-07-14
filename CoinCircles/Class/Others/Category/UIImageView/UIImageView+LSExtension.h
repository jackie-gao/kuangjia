//
//  UIImageView+LSExtension.h
//
//  Created by larson on 2016/1/17.
//  Copyright © 2016年 larson. All rights reserved.
//

// UIImageView的一些分类

#import <UIKit/UIKit.h>

@interface UIImageView (LSExtension)

/**
*  设置圆形头像
*
*  @param url   图片的url
*/
- (void)setCircleHeader:(NSString *)url;

/**
*  设置网络图片
*
*  @param url   图片的url
*/
- (void)setImageWithUrl:(NSString *)url;

/**
 *  设置带占位图的网络图片
 *
 *  @param url                       图片的url
 *  @param placeholderImageNamed     占位图
 */
- (void)setImageWithURL:(NSString *)url placeholderImageNamed:(NSString *)placeholderImageNamed;

@end
