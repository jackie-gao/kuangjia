//
//  LSCollectionViewCell.m
//  collectionView轮播图
//
//  Created by larson on 2019/2/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSCollectionViewCell.h"

@interface LSCollectionViewCell ()
@property(nonatomic,weak) UILabel *titleLabel;

@end

@implementation LSCollectionViewCell

#pragma mark - <初始化>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}



#pragma mark - <初始化子控件>
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}



#pragma mark - <setter>
// 文字的背景色
- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    
    self.titleLabel.backgroundColor = titleLabelBackgroundColor;
}

// 文字的颜色
- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    
    self.titleLabel.textColor = titleLabelTextColor;
}

// 文字的字体大小
- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    
    self.titleLabel.font = titleLabelTextFont;
}

// 设置文字
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (self.titleLabel.hidden) {
        self.titleLabel.hidden = NO;
    }
}

// 设置文字的对其方式
- (void)setTitleLabelTextAligment:(NSTextAlignment)titleLabelTextAligment
{
    _titleLabelTextAligment = titleLabelTextAligment;
    
    self.titleLabel.textAlignment = titleLabelTextAligment;
}



#pragma mark - <布局>
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    }
    else {
        self.imageView.frame = self.bounds;
        CGFloat titleLabelW = self.bounds.size.width;
        CGFloat titleLabelH = self.titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.bounds.size.height - titleLabelH;
        
        self.titleLabel.frame = kRect(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

@end
