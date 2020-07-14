//
//  LSPageControl.h
//  collectionView轮播图
//
//  Created by larson on 2019/2/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

// ----- 自定义的pageControl ----- //

#import <UIKit/UIKit.h>

// =============== 代理 =============== //
@class LSPageControl;
@protocol LSPageControlDelegate <NSObject>

@optional
- (void)LSPageControl:(LSPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end

@interface LSPageControl : UIControl

/** 圆点的自定义属性*/
@property(nonatomic,assign) Class dotViewClass;
/** 圆点的图片*/
@property(nonatomic,strong) UIImage *dotImage;
/** 当前圆点的图片*/
@property(nonatomic,strong) UIImage *currentDotImage;
/** 圆点的size，默认是8 * 8*/
@property(nonatomic,assign) CGSize dotSize;
/** 圆点的颜色*/
@property(nonatomic,strong) UIColor *dotColor;
/** 两个圆点之间的间距，默认是8*/
@property(nonatomic,assign) NSInteger spacingBetweenDots;
/** 代理*/
@property(nonatomic,weak) id<LSPageControlDelegate> delegate;
/** 控件的总页数，默认为0*/
@property(nonatomic,assign) NSInteger numberOfPages;
/** 控件所处的页数，默认为0*/
@property(nonatomic,assign) NSInteger currentPage;
/** 如果只有一个页面，则隐藏控件，默认为NO*/
@property(nonatomic,assign) BOOL hidesForSinglePage;
/** 是否通过中心点来拉伸该控件，默认为YES*/
@property(nonatomic,assign) BOOL shouldResizeFromCenter;


/// 根据页数来计算size
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end
