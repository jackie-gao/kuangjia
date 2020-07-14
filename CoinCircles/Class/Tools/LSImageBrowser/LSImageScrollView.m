//
//  LSImageScrollView.m
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSImageScrollView.h"
#import <UIImageView+WebCache.h>
#import <UIView+WebCache.h>
#import "LSImageBrowserHeader.h"
#import "LSImageItem.h"
#import "LSProgressShapeLayer.h"


const CGFloat kLSImageViewPadding = 10;
const CGFloat kLSImageViewMaxScale = 3;

@interface LSImageScrollView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation LSImageScrollView

#pragma mark - <初始化>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.bouncesZoom = YES;
    self.maximumZoomScale = kLSImageViewMaxScale;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.multipleTouchEnabled = YES;
    self.delegate = self;
    if (kImageBrowseriOS11 > 11.0) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    UIImageView *imageViewTemp = [[UIImageView alloc]init];
    imageViewTemp.backgroundColor = kBlackColor;
    imageViewTemp.contentMode = UIViewContentModeScaleAspectFill;
    imageViewTemp.clipsToBounds = YES;
    [self addSubview:imageViewTemp];
    [self adjustImageViewSize];
    self.imageView = imageViewTemp;
}



#pragma mark - <setter>
- (void)setImageItem:(LSImageItem *)imageItem
{
    if (_imageItem != imageItem) {
        _imageItem = imageItem;
    }
    [self.imageView sd_cancelCurrentImageLoad];
    
    if (_imageItem) {
        if (_imageItem.image) {
            self.imageView.image = _imageItem.image;
            _imageItem.finished = YES;
            _progressLayer.hidden = YES;
            // 调整视图
            [self adjustImageViewSize];
            return;
        }
        self.imageView.image = _imageItem.thumbImage;
        [self adjustImageViewSize];
        __weak typeof(self) kWeakSelf = self;
        [self.imageView sd_setImageWithURL:imageItem.networkImageUrl placeholderImage:_imageItem.thumbImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            !kWeakSelf.progressBlock ? : self.progressBlock(receivedSize, expectedSize, targetURL);
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            !kWeakSelf.compleedBlock ? : self.compleedBlock(image, imageURL);
            [kWeakSelf.imageView startAnimating];
        }];
    }
    else {
        [self.progressLayer stopProgressAnimation];
        self.progressLayer.hidden = YES;
        self.imageView.image = nil;
    }
}



#pragma mark - <API>
- (void)cancelCurrentImageLoading
{
    [self.imageView sd_cancelCurrentImageLoad];
}



#pragma mark - <delegate>
#pragma mark <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize size = scrollView.bounds.size;
    CGSize contentSize = scrollView.contentSize;
    CGFloat offsetX = 0;
    if (size.width > contentSize.width) {
        offsetX = (size.width - contentSize.width) / 2;
    } else {
        offsetX = 0;
    }
    
    CGFloat offsetY = 0;
    if (size.height > contentSize.height) {
        offsetY = (size.height - contentSize.height) / 2;
    } else {
        offsetY = 0;
    }
    
    self.imageView.center = CGPointMake(contentSize.width / 2 + offsetX, contentSize.height / 2 + offsetY);
}


#pragma mark <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.panGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStatePossible) {
            if ([self currentScrollViewIsTopOrBottom]) {
                return NO;
            }
        }
    }
    return YES;
}



#pragma mark - <method>
/// 调整图片的大小
- (void)adjustImageViewSize
{
    CGSize size = self.bounds.size;
    if (self.imageView.image) {
        CGSize imageSize = self.imageView.image.size;
        CGFloat width = self.bounds.size.width;
        if (imageSize.width < 80) {
            width =  imageSize.width;
        }
        CGFloat height = width * (imageSize.height / imageSize.width);
        CGRect imageViewFrame = kRect(0, 0, width, height);
        self.imageView.frame = imageViewFrame;
        
        if (height >= size.height) {
            self.imageView.center = CGPointMake(size.width / 2, height / 2);
        } else {
            self.imageView.center = CGPointMake(size.width / 2, size.height / 2);
        }
    }
    else {
        CGFloat width = size.width - kLSImageViewPadding * 2;
        self.imageView.bounds = kRect(0, 0, width, width * 2.0 / 3);
        self.imageView.center = CGPointMake(size.width / 2, size.height / 2);
    }
    
    self.contentSize = self.imageView.bounds.size;
}

/// 当前scrollView是否在顶部或底部
- (BOOL)currentScrollViewIsTopOrBottom
{
    CGPoint translation = [self.panGestureRecognizer translationInView:self];
    if (translation.y > 0 && self.contentOffset.y <= 0) {
        return YES;
    }
    
    CGFloat offsetY = floor(self.contentSize.height - self.bounds.size.height);
    if (translation.y < 0 && self.contentOffset.y >= offsetY) {
        return YES;
    }
    
    return NO;
}

@end
