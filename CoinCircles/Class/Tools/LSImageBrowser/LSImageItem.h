//
//  LSImageItem.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSImageItem : NSObject
/** 图片所属视图(可选)*/
@property(nonatomic,strong,readonly) UIView *sourceView;
/** 缩略图*/
@property(nonatomic,strong,readonly) UIImage *thumbImage;
/** 网络图片的url*/
@property(nonatomic,strong,readonly) NSURL *networkImageUrl;
/** 原图的url*/
@property(nonatomic,strong,readonly) NSURL *originalImageUrl;
/** 缩略图的url*/
@property(nonatomic,strong,readonly) NSURL *thumbImageUrl;
/** 相册图片*/
@property(nonatomic,strong,readonly) UIImage *image;
/** 是否完成*/
@property(nonatomic,assign) BOOL finished;



/**
 *  初始化缩略图图片浏览器
 *
 *  @sourceView          图片所属视图
 *  @thumbImage          缩略图
 *  @thumbImageUrl       缩略图的url
 *
 *  @return              缩略图图片浏览器
 */
- (instancetype)initWithSourceView:(UIView *)sourceView
                        thumbImage:(UIImage *)thumbImage
                     thumbImageUrl:(NSURL *)thumbImageUrl;

/**
 *  初始化网络图片浏览器
 *
 *  @sourceView              图片所属视图
 *  @networkImageUrl     网络图片的url
 *
 *  @return              图片浏览器
 */
- (instancetype)initWithSourceView:(UIImageView *)sourceView
                   networkImageUrl:(NSURL *)networkImageUrl;

/**
 *  初始化本地图片浏览器
 *
 *  @sourceView          图片所属视图
 *  @localImage          本地的图片
 *
 *  @return              本地图片浏览器
 */
- (instancetype)initWithSourceView:(UIImageView *)sourceView
                        localImage:(UIImage *)localImage;

/**
 *  初始化只有原图的图片浏览器
 *
 *  @originalImageUrl    原始图片的url
 *
 *  @return              只有原图的图片浏览器
 */
- (instancetype)initWithOriginalImageUrl:(NSURL *)originalImageUrl;

@end
