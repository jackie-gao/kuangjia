//
//  UIImageView+LSExtension.m
//
//  Created by larson on 2016/1/17.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "UIImageView+LSExtension.h"

@implementation UIImageView (LSExtension)

#pragma mark - <设置圆形头像>
- (void)setCircleHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"mine_default_icon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        self.image = image ? [image circleImage] : placeholder;
    }];
}



#pragma mark <设置网络图片>
- (void)setImageWithUrl:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}



#pragma mark - <设置带占位图的网络图片>
- (void)setImageWithURL:(NSString *)url placeholderImageNamed:(NSString *)placeholderImageNamed
{
    UIImage *placeholder = (placeholderImageNamed != nil) ? [UIImage imageNamed:placeholderImageNamed] : self.image;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        self.image = image ? image : placeholder;
    }];
}

@end
