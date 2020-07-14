//
//  LSPlaceholderTextView.m
//  larson
//
//  Created by larson on 2017/1/30.
//  Copyright © 2017年 larson. All rights reserved.
//

#import "LSPlaceholderTextView.h"

@interface LSPlaceholderTextView ()

/** 占位文字label*/
@property(nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation LSPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}



#pragma mark - <基本设置>
- (void)setup
{
    // 设置控件的弹簧效果
    self.alwaysBounceVertical = YES;
    self.font = [UIFont systemFontOfSize:14];
    
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}



#pragma mark - <action>
// 监听文字改变
- (void)textDidChange
{
    // 有文字就隐藏placeholder
    self.placeholderLabel.hidden = self.hasText;
}



#pragma mark - <更新占位文字的尺寸>
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 当textView有宽度的时候，才设置placeholder的大小
    self.placeholderLabel.LS_width = self.LS_width - 2 * self.placeholderLabel.LS_x;
    [self.placeholderLabel sizeToFit];
}



#pragma mark - <重写setter>
// 设置占位文字
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}


// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}


// 根据字体大小设置占位文字的大小
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}


// 设置内容文字
- (void)setText:(NSString *)text
{
    [super setText:text];

    // 改了文字，就改变占位文字的hidden
    [self textDidChange];
    
}


// 设置富文本
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
}



#pragma mark - <懒加载>
// 添加一个用来显示占位文字的label
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.LS_x = 4;
        placeholderLabel.LS_y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    
    return _placeholderLabel;
}


#pragma mark - <控制器销毁>
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
