//
//  LSLineLayout.h
//
//  Created by larson on 2018/3/12.
//  Copyright © 2018年 Larson. All rights reserved.
//

// ----- collectionView的自定义的线性布局 ----- //

#import <UIKit/UIKit.h>

@interface LSLineLayout : UICollectionViewFlowLayout

/** item的宽度*/
@property(nonatomic,assign) CGFloat itemWidth;
/** item的高度*/
@property(nonatomic,assign) CGFloat itemHeight;
/** 缩放最大宽度*/
@property(nonatomic,assign) CGFloat maxWidth;
/** 缩放最大高度*/
@property(nonatomic,assign) CGFloat maxHeight;
/** 间距*/
@property(nonatomic,assign) CGFloat spacing;

@end
