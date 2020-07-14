//
//  LSCollectionViewFlowLayout.h
//  shanShuiHotel
//
//  Created by larson on 2018/12/24.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

// ----- 用来设置collectionView的sessio的背景色 ----- //

#import <UIKit/UIKit.h>

@protocol LSCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>
/** 设置指定分组的背景色分组的颜色*/
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end

@interface LSCollectionViewFlowLayout : UICollectionViewFlowLayout

/** 用来存放每组的属性的数组*/
@property(nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end
