//
//  LSEmptyView.m
//  LSEmptyView
//
//  Created by larson on 2019/8/22.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "LSEmptyView.h"
#import "LSEmptyViewHeader.h"

@interface LSEmptyView ()
@property(nonatomic,strong) UIImageView *promptImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *detailsLabel;
@property(nonatomic,strong) UIButton *actionButton;
@property(nonatomic,strong) UIView  *customV;

@end

@implementation LSEmptyView
{
    CGFloat contentMaxWidth; //最大宽度
    CGFloat contentWidth;    //内容物宽度
    CGFloat contentHeight;   //内容物高度
    CGFloat subviweMargin;   //间距
}

#pragma mark - <superClassMethod>
- (void)prepare
{
    [super prepare];
    
    self.autoShowEmptyView = YES;
    // 用来判断是否设置过content的Y值
    self.contentViewY = 1000;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    contentMaxWidth = self.emptyViewIsCompleteCoverSuperView ? self.LS_width : self.LS_width - 30;
    contentWidth = 0;
    contentHeight = 0;
    subviweMargin =  self.subviewMargin ? self.subviewMargin : kEmptyViewSubviewMargin;
    
    // 占位图片
    UIImage *image = [UIImage imageNamed:self.imageString];
    if (self.image) {
        [self setupPromptImageView:self.image];
    }
    else if (image) {
        [self setupPromptImageView:image];
    }
    else {
        if (_promptImageView) {
            [self.promptImageView removeFromSuperview];
            self.promptImageView = nil;
        }
    }
    
    // 标题
    if (self.titleString.length) {
        [self setupTitleLabel:self.titleString];
    }
    else {
        if (_titleLabel) {
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
        }
    }
    
    // 详细描述
    if (self.detailString.length) {
        [self setupDetailsLabel:self.detailString];
    }
    else {
        if (_detailsLabel) {
            [self.detailsLabel removeFromSuperview];
            self.detailsLabel = nil;
        }
    }
    
    // 按钮
    if (self.buttonTitleString.length) {
        if (self.actionButtonTarget && self.actionButtonAction) {
            [self setupActionButton:self.buttonTitleString target:self.actionButtonTarget action:self.actionButtonAction buttonActionBlock:nil];
        }
        else if (self.buttonActionBlock) {
            [self setupActionButton:self.buttonTitleString target:nil action:nil buttonActionBlock:self.buttonActionBlock];
        }
        else {
            if (_actionButton) {
                [self.actionButton removeFromSuperview];
                self.actionButton = nil;
            }
        }
    }
    else {
        if (_actionButton) {
            [self.actionButton removeFromSuperview];
            self.actionButton = nil;
        }
    }
    
    // 自定义view
    if (self.customView) {
        contentWidth = self.customView.LS_width;
        contentHeight = self.customView.LS_maxY;
    }
    
    // 设置frame
    [self setSubviewFrame];
}



#pragma mark - <action>
// 操作按钮点击
- (void)handleButtonAction
{
    !self.buttonActionBlock ? : self.buttonActionBlock();
}



#pragma mark - <setter>
#pragma mark <propertiesSet>
- (void)setEmptyViewIsCompleteCoverSuperView:(BOOL)emptyViewIsCompleteCoverSuperView
{
    _emptyViewIsCompleteCoverSuperView = emptyViewIsCompleteCoverSuperView;
    
    if (emptyViewIsCompleteCoverSuperView) {
        if (!self.backgroundColor) {
            self.backgroundColor = kEmptyViewBackgroundColor;
        }
    }
    else {
        self.backgroundColor = UIColor.clearColor;
    }
}

#pragma mark <内部背景图>
- (void)setSubviewMargin:(CGFloat)subviewMargin
{
    if (_subviewMargin != subviewMargin) {
        _subviewMargin = subviewMargin;
        
        if (_promptImageView || _titleLabel || _detailsLabel || _actionButton || self.customView) {     //此判断的意思只是确定self是否已加载完毕
            [self setupSubviews];
        }
    }
}

- (void)setContentViewOffset:(CGFloat)contentViewOffset
{
    if (_contentViewOffset != contentViewOffset) {
        _contentViewOffset = contentViewOffset;
        
        if (_promptImageView || _titleLabel || _detailsLabel || _actionButton || self.customView) {
            self.LS_centerY += self.contentViewOffset;
        }
    }
}

- (void)setContentViewY:(CGFloat)contentViewY
{
    if (_contentViewY != contentViewY) {
        _contentViewY = contentViewY;
        
        if (_promptImageView || _titleLabel || _detailsLabel || _actionButton || self.customView) {
            self.LS_y = self.contentViewY;
        }
    }
}

#pragma mark <提示image>
- (void)setImageSize:(CGSize)imageSize
{
    if (_imageSize.width != imageSize.width || _imageSize.height != imageSize.height) {
        _imageSize = imageSize;
        
        if (_promptImageView) {
            [self setupSubviews];
        }
    }
}

#pragma mark <描述label>
- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    if (_titleLabelFont != titleLabelFont) {
        _titleLabelFont = titleLabelFont;
        
        if (_titleLabel) {
            [self setupSubviews];
        }
    }
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    if (_titleLabelTextColor != titleLabelTextColor) {
        _titleLabelTextColor = titleLabelTextColor;
        
        if (_titleLabel) {
            _titleLabel.textColor = titleLabelTextColor;
        }
    }
}

#pragma mark <详情描述label>
- (void)setDetailsLabeFont:(UIFont *)detailsLabeFont
{
    if (_detailsLabeFont != detailsLabeFont) {
        _detailsLabeFont = detailsLabeFont;
        
        if (_detailsLabel) {
            [self setupSubviews];
        }
    }
}

- (void)setDetailsLabelMaxLines:(NSInteger)detailsLabelMaxLines
{
    if (_detailsLabelMaxLines != detailsLabelMaxLines) {
        _detailsLabelMaxLines = detailsLabelMaxLines;
        
        if (_detailsLabel) {
            [self setupSubviews];
        }
    }
}

- (void)setDetailsLabelTextColor:(UIColor *)detailsLabelTextColor
{
    if (_detailsLabelTextColor != detailsLabelTextColor) {
        _detailsLabelTextColor = detailsLabelTextColor;
        
        if (_detailsLabel) {
            _detailsLabel.textColor = detailsLabelTextColor;
        }
    }
}

#pragma mark <actionButton>
- (void)setActionButtonFont:(UIFont *)actionButtonFont
{
    if (_actionButtonFont != actionButtonFont) {
        _actionButtonFont = actionButtonFont;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}

- (void)setActionButtonHeight:(CGFloat)actionButtonHeight
{
    if (actionButtonHeight != actionButtonHeight) {
        _actionButtonHeight = actionButtonHeight;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}

- (void)setActionButtonHorizontalMargin:(CGFloat)actionButtonHorizontalMargin
{
    if (_actionButtonHorizontalMargin != actionButtonHorizontalMargin) {
        _actionButtonHorizontalMargin = actionButtonHorizontalMargin;
        
        if (_actionButton) {
            [self setupSubviews];
        }
    }
}

#pragma mark <直接赋值>
- (void)setActionButtonCornerRadius:(CGFloat)actionButtonCornerRadius
{
    if (_actionButtonCornerRadius != _actionButtonCornerRadius) {
        _actionButtonCornerRadius = actionButtonCornerRadius;
        
        if (_actionButton) {
            _actionButton.layer.cornerRadius = actionButtonCornerRadius;
        }
    }
}

- (void)setActionButtonBorderWidth:(CGFloat)actionButtonBorderWidth
{
    if (actionButtonBorderWidth != _actionButtonBorderWidth) {
        _actionButtonBorderWidth = actionButtonBorderWidth;
        
        if (_actionButton) {
            _actionButton.layer.borderWidth = actionButtonBorderWidth;
        }
    }
}

- (void)setActionButtonBorderColor:(UIColor *)actionButtonBorderColor
{
    if (_actionButtonBorderColor != actionButtonBorderColor) {
        _actionButtonBorderColor = actionButtonBorderColor;
        
        if (_actionButton) {
            _actionButton.layer.borderColor = actionButtonBorderColor.CGColor;
        }
    }
}

- (void)setActionButtonTitleColor:(UIColor *)actionButtonTitleColor
{
    if (_actionButtonTitleColor != actionButtonTitleColor) {
        _actionButtonTitleColor = actionButtonTitleColor;
        
        if (_actionButton) {
            [_actionButton setTitleColor:actionButtonTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setActionButtonBackgroundColor:(UIColor *)actionButtonBackgroundColor
{
    if (actionButtonBackgroundColor != _actionButtonBackgroundColor) {
        _actionButtonBackgroundColor = actionButtonBackgroundColor;
        
        if (_actionButton) {
            _actionButton.backgroundColor = actionButtonBackgroundColor;
        }
    }
}



#pragma mark - <method>
/// 设置subview的frame
- (void)setSubviewFrame
{
    // emptyView的初始宽高
    CGFloat originEmptyWidth = self.LS_width;
    CGFloat originEmptyHeight = self.LS_height;
    
    CGFloat emptyViewCenterX = originEmptyWidth / 2;
    CGFloat emptyViewCenterY = originEmptyHeight / 2;
    
    // 不完全覆盖父视图时，重新设置self的frame(大小为content的大小)
    if (!self.emptyViewIsCompleteCoverSuperView) {
        self.LS_size = CGSizeMake(contentWidth, contentHeight);
    }
    self.center = CGPointMake(emptyViewCenterX, emptyViewCenterY);
    
    // 设置contentView
    self.contentView.LS_size = CGSizeMake(contentWidth, contentHeight);
    if (self.emptyViewIsCompleteCoverSuperView) {
        self.contentView.center = CGPointMake(emptyViewCenterX, emptyViewCenterY);
    }
    
    // 子控件的centerX设置
    CGFloat centerX = self.contentView.LS_width / 2;
    if (self.customView) {
        self.customView.LS_centerX = centerX;
    }
    else {
        self.promptImageView.LS_centerX = centerX;
        self.titleLabel.LS_centerX = centerX;
        self.detailsLabel.LS_centerX = centerX;
        self.actionButton.LS_centerX = centerX;
    }
    
    if (self.contentViewOffset) {           // 是否设置offset
        self.LS_centerY += self.contentViewOffset;
    }
    else if (self.contentViewY < 1000) {    // 是否设置y坐标
        self.LS_y = self.contentViewY;
    }
    
    // 是否忽略scrollView的contentInset
    if (self.ignoreContentInset && [self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        self.LS_centerX -= scrollView.contentInset.left;
        self.LS_centerY -= scrollView.contentInset.top;
    }
}

/// 设置提示图片
- (void)setupPromptImageView:(UIImage *)image
{
    self.promptImageView.image = image;
    
    CGFloat imageViewWidth = image.size.width;
    CGFloat imageViewHeight = image.size.height;
    
    // 设置了宽高大小
    if (self.imageSize.width && self.imageSize.height) {
        if (imageViewWidth > imageViewHeight) {  // 以宽为基准，按比例缩放高度
            imageViewHeight = (imageViewHeight / imageViewWidth) * self.imageSize.width;
            imageViewWidth = self.imageSize.width;
        } else {  // 以高为基准，按比例缩放
            imageViewWidth = (imageViewWidth / imageViewHeight) * self.imageSize.height;
            imageViewHeight = self.imageSize.height;
        }
    }
    self.promptImageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewHeight);
    
    contentWidth = self.promptImageView.LS_width;
    contentHeight = self.promptImageView.LS_maxY;
}

/// 设置titleLabel
- (void)setupTitleLabel:(NSString *)titleString
{
    UIFont *font = self.titleLabelFont.pointSize ? self.titleLabelFont : kEmptyViewTitleLabelFont;
    CGFloat fontSize = font.pointSize;
    UIColor *textColor = self.titleLabelTextColor ? self.titleLabelTextColor : kEmptyViewBlackColor;
    CGFloat width = [self returnTextWidth:titleString size:CGSizeMake(contentMaxWidth, fontSize) font:font].width;
    
    self.titleLabel.frame = CGRectMake(0, contentHeight + subviweMargin, width, fontSize);
    self.titleLabel.font = font;
    self.titleLabel.text = titleString;
    self.titleLabel.textColor = textColor;
    
    contentWidth = width > contentWidth ? width : contentWidth;
    contentHeight = self.titleLabel.LS_maxY;
}

/// 设置detailsLabel
- (void)setupDetailsLabel:(NSString *)detailsString
{
    UIColor *textColor = self.detailsLabelTextColor ? self.detailsLabelTextColor : kEmptyViewGrayColor;
    UIFont *font = self.detailsLabeFont.pointSize ? self.detailsLabeFont : kEmptyViewDetailsLabelFont;
    CGFloat fontSize = font.pointSize;
    
    // 如果没有设置最大行数，默认设置为2行的高度
    CGFloat maxHeight = self.detailsLabelMaxLines ? self.detailsLabelMaxLines * (fontSize + 5) : 2 * (fontSize + 5);
    
    CGSize size = [self returnTextWidth:detailsString size:CGSizeMake(contentMaxWidth, maxHeight) font:font];
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    self.detailsLabel.font = font;
    self.detailsLabel.frame = CGRectMake(0, contentHeight + subviweMargin, width, height);
    self.detailsLabel.text = detailsString;
    self.detailsLabel.textColor = textColor;
    
    contentWidth = width > contentWidth ? width : contentWidth;
    contentHeight = self.detailsLabel.LS_maxY;
}

/// 设置button
- (void)setupActionButton:(NSString *)buttonTitle target:(id)target action:(SEL)action buttonActionBlock:(LSActionTapBlock)buttonActionBlock
{
    UIFont *font = self.actionButtonFont.pointSize ? self.actionButtonFont : kEmptyViewButtonFont;
    CGFloat fontSize = font.pointSize;
    UIColor *titleColor = self.actionButtonTitleColor ? self.actionButtonTitleColor : kEmptyViewBlackColor;
    UIColor *backgroundColor = self.actionButtonBackgroundColor ? self.actionButtonBackgroundColor : UIColor.whiteColor;
    UIColor *borderColor = self.actionButtonBorderColor ? self.actionButtonBorderColor : kEmptyViewRGBA(0.8, 0.8, 0.8, 1);
    CGFloat borderWidth = self.actionButtonBorderWidth ? self.actionButtonBorderWidth : 0;
    CGFloat cornerRadius = self.actionButtonCornerRadius ? self.actionButtonCornerRadius : 5;
    CGFloat horizontalMargin = self.actionButtonHorizontalMargin ? self.actionButtonHorizontalMargin : kEmptyViewButtonHorizontalMargin;
    CGFloat height = self.actionButtonHeight ? self.actionButtonHeight : kEmptyViewButtonHeight;
    CGSize textSize = [self returnTextWidth:buttonTitle size:CGSizeMake(contentMaxWidth, fontSize) font:font];
    if (height < textSize.height) {
        height = textSize.height + 4;
    }
    
    // 按钮的高度
    CGFloat buttonWidth = textSize.width + horizontalMargin * 2;
    CGFloat buttonHeight = height;
    buttonWidth = buttonWidth > contentMaxWidth ? contentMaxWidth : buttonWidth;
    
    self.actionButton.frame = CGRectMake(0, contentHeight + subviweMargin, buttonWidth, buttonHeight);
    [self.actionButton setTitle:buttonTitle forState:UIControlStateNormal];
    self.actionButton.titleLabel.font = font;
    self.actionButton.backgroundColor = backgroundColor;
    [self.actionButton setTitleColor:titleColor forState:UIControlStateNormal];
    self.actionButton.layer.borderColor = borderColor.CGColor;
    self.actionButton.layer.borderWidth = borderWidth;
    self.actionButton.layer.cornerRadius = cornerRadius;
    
    // 添加事件
    if (target && action) {
        [self.actionButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self.actionButton addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (buttonActionBlock) {
        [self.actionButton addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    contentWidth = buttonWidth > contentWidth ? buttonWidth : contentWidth;
    contentHeight = self.actionButton.LS_maxY;
}

/// 计算文字的size
- (CGSize)returnTextWidth:(NSString *)text size:(CGSize)size font:(UIFont *)font
{
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    return textSize;
}



#pragma mark - <lazy>
- (UIImageView *)promptImageView
{
    if (!_promptImageView) {
        _promptImageView = [[UIImageView alloc]init];
        _promptImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_promptImageView];
    }
    return _promptImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailsLabel];
    }
    return _detailsLabel;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc]init];
        _actionButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_actionButton];
    }
    return _actionButton;
}

@end
