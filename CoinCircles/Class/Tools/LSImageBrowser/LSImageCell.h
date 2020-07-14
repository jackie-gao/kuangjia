//
//  LSImageCell.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSImageScrollView.h"

@class LSImageItem;

@interface LSImageCell : UICollectionViewCell
@property(nonatomic,strong) LSImageItem *imageItem;



/**
 *  快速创建collectionCell
 *
 *  @collectionView     collectionView
 *  @indexPath          选择的下标
 *
 *  @return             collectionViewCell
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

/**
 *  获取当前的缩放视图
 *
 *  @collectionView     collectionView
 *  @indexPath          图片scrollView的页码
 *
 *  @return             collectionViewCell
 */
+ (LSImageScrollView *)collectionView:(UICollectionView *)collectionView
               imageScrollViewForPage:(NSInteger)page;

/** 是否隐藏进度视图*/
- (void)progressLayerIsHidden:(BOOL)hidden;

@end
