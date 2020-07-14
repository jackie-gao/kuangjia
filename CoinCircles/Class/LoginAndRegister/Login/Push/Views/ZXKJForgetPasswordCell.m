//
//  ZXKJForgetPasswordCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJForgetPasswordCell.h"

@interface ZXKJForgetPasswordCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewTopCons;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIView *phoneNumLine;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UIView *oldPwdLine;
@property (weak, nonatomic) IBOutlet UITextField *neoPwdTF;
@property (weak, nonatomic) IBOutlet UIView *neoPwdLine;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation ZXKJForgetPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.indicatorViewTopCons.constant -= kHeightNavigationBar;
    
    if (kUserDefaultsGetValueWithKey(ZCKJMobileKey)) {
        self.phoneNumTF.text = kUserDefaultsGetValueWithKey(ZCKJMobileKey);
    }
    
    [self.phoneNumTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.oldPwdTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.neoPwdTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumTF.delegate = self;
    self.oldPwdTF.delegate = self;
    self.neoPwdTF.delegate = self;
}



#pragma mark - <action>
#pragma mark <buttonAction>
// 确认修改
- (IBAction)confirmModifyButtonAction {
    if (![self checkResetParameter]) return;
    
    !self.resetPasswordBlock ? : self.resetPasswordBlock(self.phoneNumTF.text, self.neoPwdTF.text);
}


#pragma mark <textFieldAction>
- (void)textFieldInputState:(UITextField *)textField
{
    // 确定按钮颜色
    if (self.phoneNumTF.text.length != 0 && self.oldPwdTF.text.length != 0 && self.neoPwdTF.text.length != 0) {
        self.confirmButton.backgroundColor = kTintColor;
    } else {
        self.confirmButton.backgroundColor = kRGBColor(153, 153, 153);
    }
}



#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneNumTF) {
        self.phoneNumLine.backgroundColor = kTintColor;
    }
    else if (textField == self.oldPwdTF) {
        self.oldPwdLine.backgroundColor = kTintColor;
    }
    else if (textField == self.neoPwdTF) {
        self.neoPwdLine.backgroundColor = kTintColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneNumTF) {
        self.phoneNumLine.backgroundColor = kHomochromyColor(221);
    }
    else if (textField == self.oldPwdTF) {
        self.oldPwdLine.backgroundColor = kHomochromyColor(221);
    }
    else if (textField == self.neoPwdTF) {
        self.neoPwdLine.backgroundColor = kHomochromyColor(221);
    }
}

// 限制输入的位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTF) {
        NSString *phoneNumStr = self.phoneNumTF.text;
        NSInteger phoneNumLength = 11;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (phoneNumStr.length >= phoneNumLength) {
            phoneNumStr = [textField.text substringToIndex:phoneNumLength];
            return NO;
        }
    }
    else if (textField == self.oldPwdTF || textField == self.neoPwdTF) {
        NSString *pwdStr = textField.text;
        NSInteger pwdLength = 16;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (pwdStr.length >= pwdLength) {
            pwdStr = [textField.text substringToIndex:pwdLength];
            return NO;
        }
    }

    return YES;
}



#pragma mark - <method>
/// 检测重置密码的参数
- (BOOL)checkResetParameter
{
    NSString *phoneNumStr = self.phoneNumTF.text;
    NSString *oldPwdStr = self.oldPwdTF.text;
    NSString *neoPwdStr = self.neoPwdTF.text;
    if (![phoneNumStr isValidMobileNumber]) {
        [LSMaskTool showInfoMessage:@"手机号码格式错误"];
        return NO;
    }
    else if (![oldPwdStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"旧密码格式错误"];
        return NO;
    }
    else if (![neoPwdStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"新密码格式错误"];
        return NO;
    }
    else if ([oldPwdStr isEqualToString:neoPwdStr]) {
        [LSMaskTool showInfoMessage:@"新密码和旧密码不能一样"];
        return NO;
    }
    
    return YES;
}



#pragma mark <API>
- (void)setupKeyboard
{
    if (!self.phoneNumTF.text.length) {
        [self.phoneNumTF becomeFirstResponder];
    }
    else {
        [self.oldPwdTF becomeFirstResponder];
    }
}

@end
