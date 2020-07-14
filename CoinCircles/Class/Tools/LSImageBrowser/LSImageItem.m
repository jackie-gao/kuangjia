//
//  LSImageItem.m
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSImageItem.h"

@interface LSImageItem ()
@property(nonatomic,strong,readwrite) UIView *sourceView;
@property(nonatomic,strong,readwrite) UIImage *thumbImage;
@property(nonatomic,strong,readwrite) NSURL *networkImageUrl;
@property(nonatomic,strong,readwrite) NSURL *originalImageUrl;
@property(nonatomic,strong,readwrite) NSURL *thumbImageUrl;
@property(nonatomic,strong,readwrite) UIImage *image;

@end

@implementation LSImageItem

#pragma mark - <初始化>
// 缩略图
- (instancetype)initWithSourceView:(UIView *)sourceView thumbImage:(UIImage *)thumbImage thumbImageUrl:(NSURL *)thumbImageUrl
{
    if (self = [super init]) {
        self.sourceView = sourceView;
        self.thumbImage = thumbImage;
        self.networkImageUrl = thumbImageUrl;
    }
    return self;
}

// 网络图片
- (instancetype)initWithSourceView:(UIImageView *)sourceView networkImageUrl:(NSURL *)networkImageUrl
{
    return [self initWithSourceView:sourceView thumbImage:sourceView.image thumbImageUrl:networkImageUrl];
}

// 本地图片
- (instancetype)initWithSourceView:(UIImageView *)sourceView localImage:(UIImage *)localImage
{
    if (self = [super init]) {
        self.sourceView = sourceView;
        self.thumbImage = localImage;
        self.networkImageUrl = nil;
        self.image = localImage;
    }
    return self;
}

// 原图
- (instancetype)initWithOriginalImageUrl:(NSURL *)originalImageUrl
{
    if (self = [super init]) {
        self.networkImageUrl = originalImageUrl;
        self.originalImageUrl = originalImageUrl;
    }
    return self;
}

@end
