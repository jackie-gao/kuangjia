//
//  LSEmptyView.h
//  LSEmptyView
//
//  Created by larson on 2019/8/22.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "LSEmptyBaseView.h"

@interface LSEmptyView : LSEmptyBaseView
/** 是否自动显示和隐藏emptyView，default=YES*/
@property(nonatomic,assign) BOOL autoShowEmptyView;

/**
  展位图是否完全覆盖父视图，default is NO
  当设置为YES后，占位图的backgroundColor默认为浅白色，可自行设置
 */
@property(nonatomic,assign) BOOL emptyViewIsCompleteCoverSuperView;

/** 子控件之间的间距*/
@property(nonatomic,assign) CGFloat subviewMargin;
/** 垂直方向偏移(此属性与contentOffset互斥，只有一个有效)*/
@property(nonatomic,assign) CGFloat contentViewOffset;
/** y坐标*/
@property(nonatomic,assign) CGFloat contentViewY;
/** 是否忽略scrollView的contentInset*/
@property(nonatomic,assign) BOOL ignoreContentInset;

// ----------------------------- image ----------------------------- //
/** 图片可设置固定大小(default=图片实际大小)*/
@property(nonatomic,assign) CGSize imageSize;

// ----------------------------- titleLabel ----------------------------- //
/** 标题字体大小，default=16*/
@property(nonatomic,strong) UIFont *titleLabelFont;
/** 标题文字颜色*/
@property(nonatomic,strong) UIColor *titleLabelTextColor;

// ----------------------------- detailsLabel ----------------------------- //
/** 详细秒速字体大小，default=14*/
@property(nonatomic,strong) UIFont *detailsLabeFont;
/** 详细描述最大行数，default=2*/
@property(nonatomic,assign) NSInteger detailsLabelMaxLines;
/** 详情描述文字颜色*/
@property(nonatomic,strong) UIColor *detailsLabelTextColor;

// ----------------------------- button ----------------------------- //
/** 按钮字体大小，defaule is 14*/
@property(nonatomic,strong) UIFont *actionButtonFont;
/** 按钮的高度，default is 40*/
@property(nonatomic,assign) CGFloat actionButtonHeight;
/** 水平方向内边距，default is 30*/
@property(nonatomic,assign) CGFloat actionButtonHorizontalMargin;
/** 按钮文字颜色*/
@property(nonatomic,strong) UIColor *actionButtonTitleColor;
/** 按钮背景颜色*/
@property(nonatomic,strong) UIColor *actionButtonBackgroundColor;
/** 按钮圆角大小，default is 5*/
@property(nonatomic,assign) CGFloat actionButtonCornerRadius;
/** 按钮边框的宽度，default is 0*/
@property(nonatomic,assign) CGFloat actionButtonBorderWidth;
/** 按钮边框颜色*/
@property(nonatomic,strong) UIColor *actionButtonBorderColor;

@end
