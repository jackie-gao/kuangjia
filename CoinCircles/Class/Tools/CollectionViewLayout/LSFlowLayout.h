//
//  LSFlowLayout.h
//  水平滚动
//
//  Created by larson on 2019/3/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSFlowLayout : UICollectionViewFlowLayout

/**
 *  创建flowLayout对象
 *
 *  @insets                        偏移值
 *  @miniLineSpace                 同一组当中，行与行之间的最小行间距，但是不同组之间的不同行cell不受这个值影响。
 *  @miniInterItemSpace            同一行的cell中互相之间的最小间隔，设置这个值之后，那么cell与cell之间至少为这个值
 *  @itemSize                      item的大小
 *
 *  @return                        创建好的对象
 */
- (instancetype)initWithSectionInset:(UIEdgeInsets)insets andMiniLineSapce:(CGFloat)miniLineSpace andMiniInterItemSpace:(CGFloat)miniInterItemSpace andItemSize:(CGSize)itemSize;

@end

NS_ASSUME_NONNULL_END
