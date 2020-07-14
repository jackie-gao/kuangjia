//
//  ZXKJLoginCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJLoginCell.h"
#import "ZXKJForgetPasswordViewController.h"        // 忘记密码
#import "ZXKJRegisterViewController.h"              // 注册

@interface ZXKJLoginCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewTopCons;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIView *phoneNumLine;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZXKJLoginCell

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
        [self textFieldInputState:self.phoneNumTF];
    }

    [self.phoneNumTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumTF.delegate = self;
    self.passwordTF.delegate = self;
}



#pragma mark - <setter>
- (void)setPhoneNum:(NSString *)phoneNum
{
    _phoneNum = [phoneNum copy];
    
    self.phoneNumTF.text = phoneNum;
}



#pragma mark - <action>
#pragma mark <buttonAction>
// 密码显示模式
- (IBAction)passwordShowModeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

// 忘记密码
- (IBAction)forgetPasswordButtonAction:(UIButton *)sender {
    ZXKJForgetPasswordViewController *forgetPasswordVC = [[ZXKJForgetPasswordViewController alloc]init];
    [kContainerVC(self).navigationController pushViewController:forgetPasswordVC animated:YES];
}

// 登录
- (IBAction)loginButtonAction:(UIButton *)sender {
    if (![self checkLoginParameter]) return;
    
    !self.loginBlock ? : self.loginBlock(self.phoneNumTF.text, self.passwordTF.text);
}

// 快速注册
- (IBAction)registerButtonAction:(UIButton *)sender {
    ZXKJRegisterViewController *registerVC = [[ZXKJRegisterViewController alloc]init];
    [kContainerVC(self).navigationController pushViewController:registerVC animated:YES];
}


#pragma mark <textFieldAction>
- (void)textFieldInputState:(UITextField *)textField
{
    // 登录按钮颜色
    if (self.phoneNumTF.text.length != 0 && self.passwordTF.text.length != 0) {
        self.loginButton.backgroundColor = kTintColor;
    } else {
        self.loginButton.backgroundColor = kRGBColor(153, 153, 153);
    }
}



#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneNumTF) {
        self.phoneNumLine.backgroundColor = kTintColor;
    }
    else if (textField == self.passwordTF) {
        self.passwordLine.backgroundColor = kTintColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneNumTF) {
        self.phoneNumLine.backgroundColor = kHomochromyColor(221);
    }
    else if (textField == self.passwordTF) {
        self.passwordLine.backgroundColor = kHomochromyColor(221);
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
    else if (textField == self.passwordTF) {
        NSString *passwordStr = self.passwordTF.text;
        NSInteger passwordLength = 16;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (passwordStr.length >= passwordLength) {
            passwordStr = [textField.text substringToIndex:passwordLength];
            return NO;
        }
    }
    
    return YES;
}



#pragma mark - <method>
// 检测登录参数
- (BOOL)checkLoginParameter
{
    NSString *phoneNumStr = self.phoneNumTF.text;
    NSString *passwordStr = self.passwordTF.text;
    if (![phoneNumStr isValidMobileNumber]) {
        [LSMaskTool showInfoMessage:@"手机号码格式错误"];
        return NO;
    }
    else if (![passwordStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"密码格式不正确"];
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
        [self.passwordTF becomeFirstResponder];
    }
}

@end
