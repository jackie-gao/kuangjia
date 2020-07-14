//
//  LSTextField.m
//
//  Created by larson on 2016/12/29.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSTextField.h"
#import <objc/runtime.h>

@implementation LSTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 光标颜色
    self.tintColor = kTintColor;
}



#pragma mark - <重写textField的获取和失去焦点的方法>
- (BOOL)becomeFirstResponder
{
    
    UIColor *color = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    
    NSMutableAttributedString *placeholderString = [NSMutableAttributedString.alloc initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : color}];
    self.attributedPlaceholder = placeholderString;
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UIColor *color = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
    
    NSMutableAttributedString *placeholderString = [NSMutableAttributedString.alloc initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : color}];
    self.attributedPlaceholder = placeholderString;
    
    return [super resignFirstResponder];
}



#pragma mark - <外界修改占位文字颜色>
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    // 修改占位文字颜色
    NSMutableAttributedString *placeholderString = [NSMutableAttributedString.alloc initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : placeholderColor}];
    self.attributedPlaceholder = placeholderString;
}

@end





