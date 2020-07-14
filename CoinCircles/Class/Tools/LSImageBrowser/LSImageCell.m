//
//  LSImageCell.m
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSImageCell.h"
#import "LSImageItem.h"
#import "LSProgressShapeLayer.h"
#import "LSImageBrowserHeader.h"

@interface LSImageCell ()
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) LSImageScrollView *imageScrollView;
@property(nonatomic,strong) LSProgressShapeLayer *progressLayer;
@property(nonatomic,assign) CGRect rect;

@end

@implementation LSImageCell

#pragma mark - <initialize>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.rect = frame;
        [self setupBasic];
    }
    return self;
}



#pragma mark - <setup>
- (void)setupBasic
{
    [self.contentView addSubview:self.imageScrollView];
    [self.layer addSublayer:self.progressLayer];
}



#pragma mark - <setter>
-(void)setImageItem:(LSImageItem *)imageItem
{
    _imageItem = imageItem;
    
    self.imageScrollView.imageItem = imageItem;
    
    kWeakSelf(self);
    self.imageScrollView.progressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        kDispatch_main_thread(^{
            kStrongSelf(self);
            CGFloat progress = receivedSize / expectedSize;
            self.progressLayer.hidden = NO;
            self.progressLayer.strokeEnd = MAX(progress, 0.01);
        })
    };
    
    self.imageScrollView.compleedBlock = ^(UIImage *image, NSURL *imageURL) {
        kDispatch_main_thread(^{
            kStrongSelf(self);
            self.progressLayer.hidden = YES;
            [self.progressLayer stopProgressAnimation];
        })
    };
}



#pragma mark - <API>
// 快速创建collectionCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    LSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LSImageCell class]) forIndexPath:indexPath];
    CGRect rect = cell.frame;
    rect.size.width = collectionView.bounds.size.width - kImageBrowserCollectionMargin;
    cell.frame = rect;
    cell.collectionView = collectionView;
    
    return cell;
}

// 获取当前的缩放视图
+ (LSImageScrollView *)collectionView:(UICollectionView *)collectionView imageScrollViewForPage:(NSInteger)page
{
    [collectionView layoutIfNeeded];
    
    LSImageCell *cell = (LSImageCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0]];
    
    return cell.imageScrollView;
}

- (void)progressLayerIsHidden:(BOOL)hidden
{
    self.progressLayer.hidden = hidden;
}



#pragma mark - <lazy>
- (LSImageScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        CGSize size = self.rect.size;
        _imageScrollView = [[LSImageScrollView alloc]initWithFrame:kRect(0, 0, size.width, size.height)];
    }
    return _imageScrollView;
}

- (LSProgressShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        CGSize size = self.rect.size;
        _progressLayer = [[LSProgressShapeLayer alloc]initWithFrame:kRect(0, 0, 40, 40)];
        _progressLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35].CGColor;
        _progressLayer.position = CGPointMake(size.width / 2, size.height / 2);
        _progressLayer.hidden = YES;
    }
    return _progressLayer;
}



#pragma mark - <systemMethod>
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.rect.size;
    self.imageScrollView.bounds = kRect(0, 0, size.width, size.height);
    self.imageScrollView.center = CGPointMake(size.width / 2, size.height / 2);
}

@end
