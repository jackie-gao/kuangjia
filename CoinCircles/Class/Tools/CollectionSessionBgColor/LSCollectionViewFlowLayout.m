//
//  LSCollectionViewFlowLayout.m
//  shanShuiHotel
//
//  Created by larson on 2018/12/24.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

#import "LSCollectionViewFlowLayout.h"
#import "LSCollectionReusableView.h"
#import "LSCollectionViewLayoutAttributes.h"
#import <objc/runtime.h>

@implementation LSCollectionViewFlowLayout

#pragma mark - <初始化>
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.decorationViewAttrs = [@[] mutableCopy];
        [self setup];
    }
    return self;
}



#pragma mark - <基本设置>
- (void)setup
{
    [self registerClass:[LSCollectionReusableView class] forDecorationViewOfKind:NSStringFromClass([LSCollectionReusableView class])];
}



#pragma mark - <>
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.decorationViewAttrs removeAllObjects];
    
    // 是否执行了代理方法
    NSInteger numberOfSessions = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (!numberOfSessions || ![delegate conformsToProtocol:@protocol(LSCollectionViewDelegateFlowLayout)]) {
        return;
    }
    
    
    for (NSInteger section = 0; section < numberOfSessions; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        
        if (!firstItem || !lastItem) {
            continue;
        }
        
        UIEdgeInsets sectionInset = [self sectionInset];
        
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            sectionInset = inset;
        }
        
        
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        }else{
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        
        // 定义
        LSCollectionViewLayoutAttributes *attr = [LSCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:NSStringFromClass([LSCollectionReusableView class]) withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        
        attr.backgroundColor = [delegate collectionView:self.collectionView layout:self backgroundColorForSection:section];
        [self.decorationViewAttrs addObject:attr];
    }
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    return attrs;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:NSStringFromClass([LSCollectionReusableView class])]) {
        return [self.decorationViewAttrs objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}

@end
