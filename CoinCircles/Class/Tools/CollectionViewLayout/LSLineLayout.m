//
//  LSLineLayout.m
//
//  Created by larson on 2018/3/12.
//  Copyright © 2018年 Larson. All rights reserved.
//

#import "LSLineLayout.h"

@implementation LSLineLayout


- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(self.itemWidth, self.itemHeight);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = self.spacing;
    // 内部边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, inset);
    
    // 和pageEnable来配合来使用建议的分页效果
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrArray = [super layoutAttributesForElementsInRect:rect];
    // 中心点位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 可视范围
    CGRect seeRect = CGRectZero;
    seeRect.origin = self.collectionView.contentOffset;
    seeRect.size = self.collectionView.bounds.size;
    
    // 布局属性
    for (UICollectionViewLayoutAttributes *attrs in attrArray) {
//        CGFloat delta = ABS(attrs.center.x - centerX);
//        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
//        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
        if (!CGRectIntersectsRect(seeRect, attrs.frame)) continue;
        // item的中心x
        CGFloat itemCenterX = attrs.center.x;
        // 宽度缩放比例
        CGFloat widthScale = (1 - ABS(centerX - itemCenterX) / self.collectionView.bounds.size.width / 2) * self.maxWidth / self.itemWidth;
        widthScale = widthScale < 1.0 ? 1.0 : widthScale;
        // 高度缩放比例
        CGFloat heightScale = self.itemWidth * widthScale * self.maxHeight / self.maxWidth / self.itemHeight;
        
        attrs.transform3D = CATransform3DMakeScale(widthScale, heightScale, 1.0);
    }
    
    return attrArray;
}



/**
 * 1.这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 * 2.proposedContentOffset：cell本来应该停留的位置
 * 3.withScrollingVelocity： 给cell设置的停留位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 将最接近中间的cell，偏移到collectionView的中心位置
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}

@end





