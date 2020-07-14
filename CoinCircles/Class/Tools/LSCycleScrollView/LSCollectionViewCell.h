//
//  LSCollectionViewCell.h
//  collectionView轮播图
//
//  Created by larson on 2019/2/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) UIImageView *imageView;
@property(nonatomic,copy) NSString *title;

/** 文字的颜色*/
@property(nonatomic,strong) UIColor *titleLabelTextColor;
/** 文字的背景色*/
@property(nonatomic,strong) UIColor *titleLabelBackgroundColor;
/** 文字的字体大小*/
@property(nonatomic,strong) UIFont *titleLabelTextFont;
/** 文字的高度*/
@property(nonatomic,assign) CGFloat titleLabelHeight;
/** 文字的对齐方式*/
@property(nonatomic,assign) NSTextAlignment titleLabelTextAligment;

/** 是否已经配置*/
@property(nonatomic,assign) BOOL hasConfigured;
/** 只展示文字轮播*/
@property(nonatomic,assign) BOOL onlyDisplayText;

@end
