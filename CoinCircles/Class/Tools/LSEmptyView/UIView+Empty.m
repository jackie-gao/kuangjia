//
//  UIView+Empty.m
//  LSEmptyView
//
//  Created by larson on 2019/8/23.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>
#import "LSEmptyViewHeader.h"

@implementation UIView (Empty)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}



#pragma mark - <setter/getter>
static char kEmptyViewKey;
- (LSEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, &kEmptyViewKey);
}

- (void)setEmptyView:(LSEmptyView *)emptyView
{
    if (emptyView != self.emptyView) {
        objc_setAssociatedObject(self, &kEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[LSEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.emptyView];
        // 添加时默认隐藏
        self.emptyView.hidden = YES;
    }
}



#pragma mark - <method>
#pragma mark <private method>
// 总数据数(UITableView和UICollectionView有效)
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }
    else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    
    return totalCount;
}

- (void)getDataAndSet
{
    // 没有设置emptyView的直接返回
    if (!self.emptyView) return;
    
    if ([self totalDataCount] == 0) {
        [self show];
    }
    else {
        [self hide];
    }
}

- (void)show
{
    // 当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用ls_showEmptyView
    if (!self.emptyView.autoShowEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    
    [self ls_showEmptyView];
}

- (void)hide
{
    if (!self.emptyView.autoShowEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    
    [self ls_hideEmptyView];
}


#pragma mark <publice method>
- (void)ls_showEmptyView
{
    [self.emptyView.superview layoutSubviews];
    self.emptyView.hidden = NO;
    
    // 让emptyBGView始终保持在最上面
    [self bringSubviewToFront:self.emptyView];
}

- (void)ls_hideEmptyView
{
    self.emptyView.hidden = YES;
}

- (void)ls_startLoading
{
    self.emptyView.hidden = YES;
}

- (void)ls_endLoading
{
    self.emptyView.hidden = [self totalDataCount];
}

@end





// ---------------------------- UITableView ---------------------------- //
@implementation UITableView (Empty)
+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ls_reloadData)];
    
    // section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(ls_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(ls_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(ls_reloadSections:withRowAnimation:)];
    
    // row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(ls_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(ls_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(ls_reloadRowsAtIndexPaths:withRowAnimation:)];
}



#pragma mark - <刷新数据>
- (void)ls_reloadData
{
    [self ls_reloadData];
    [self getDataAndSet];
}


#pragma mark - <刷新section>
- (void)ls_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)ls_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)ls_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_reloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

#pragma mark - <刷新row>
- (void)ls_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)ls_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

- (void)ls_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self ls_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

@end





// ---------------------------- UICollectionView ---------------------------- //
@implementation UICollectionView (Empty)
+(void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ls_reloadData)];
    
    // section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(ls_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(ls_deleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(ls_reloadSections:)];
    
    // item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(ls_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(ls_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(ls_reloadItemsAtIndexPaths:)];
}



#pragma mark - <刷新数据>
- (void)ls_reloadData
{
    [self ls_reloadData];
    [self getDataAndSet];
}


#pragma mark - <刷新section>
- (void)ls_insertSections:(NSIndexSet *)sections
{
    [self ls_insertSections:sections];
    [self getDataAndSet];
}

- (void)ls_deleteSections:(NSIndexSet *)sections
{
    [self ls_deleteSections:sections];
    [self getDataAndSet];
}

- (void)ls_reloadSections:(NSIndexSet *)sections
{
    [self ls_reloadSections:sections];
    [self getDataAndSet];
}


#pragma mark - <刷新item>
- (void)ls_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self ls_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

- (void)ls_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self ls_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

- (void)ls_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [self ls_reloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end
