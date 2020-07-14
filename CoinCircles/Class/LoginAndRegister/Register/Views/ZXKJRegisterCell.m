//
//  ZXKJRegisterCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRegisterCell.h"
#import "ZXKJServeProtocolViewController.h"     // 用户服务协议

@interface ZXKJRegisterCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewTopCons;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIView *phoneNumLine;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;
// 邀请码
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIView *inviteCodeLine;
@property (weak, nonatomic) IBOutlet UIButton *readAndAgreeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation ZXKJRegisterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.indicatorViewTopCons.constant -= kHeightNavigationBar;
    
    [self.phoneNumTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.inviteCodeTF addTarget:self action:@selector(textFieldInputState:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumTF.delegate = self;
    self.passwordTF.delegate = self;
    self.inviteCodeTF.delegate = self;
}



#pragma mark - <action>
#pragma mark <buttonAction>
// 密码显示模式
- (IBAction)passwordShowModeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

// 阅读并同意
- (IBAction)readAndAgreeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.phoneNumTF.text.length != 0 &&
        self.passwordTF.text.length != 0 &&
        sender.selected == YES)
    {
        self.confirmButton.backgroundColor = kTintColor;
    } else {
        self.confirmButton.backgroundColor = kRGBColor(153, 153, 153);
    }
}

// 用户服务协议
- (IBAction)userServeProtocolButtonAction:(UIButton *)sender {
    ZXKJServeProtocolViewController *serveProtocolVC = [[ZXKJServeProtocolViewController alloc]init];
    [kContainerVC(self).navigationController pushViewController:serveProtocolVC animated:YES];
}

// 注册
- (IBAction)confirmRegisterButtonAction:(UIButton *)sender {
    if (![self checkRegisterParameter]) {
        return;
    }
    !self.registerBlock ? : self.registerBlock(self.phoneNumTF.text, self.passwordTF.text, self.inviteCodeTF.text);
}


#pragma mark <textFieldAction>
- (void)textFieldInputState:(UITextField *)textField
{
    // 登录按钮颜色
    if (self.phoneNumTF.text.length != 0 &&
        self.passwordTF.text.length != 0 &&
        self.readAndAgreeButton.selected == YES) {
        self.confirmButton.backgroundColor = kTintColor;
    }
    else {
        self.confirmButton.backgroundColor = kRGBColor(153, 153, 153);
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
    else if (textField == self.inviteCodeTF) {
        self.inviteCodeLine.backgroundColor = kTintColor;
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
    else if (textField == self.inviteCodeTF) {
        self.inviteCodeLine.backgroundColor = kHomochromyColor(221);
    }
}

// 限制输入的位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTF) {
        NSString *phoneNum = self.phoneNumTF.text;
        NSInteger phoneNumLength = 11;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (phoneNum.length >= 11) {
            phoneNum = [textField.text substringToIndex:phoneNumLength];
            return NO;
        }
    }
    else if (textField == self.passwordTF) {
        NSString *pwdStr = textField.text;
        NSInteger pwdLength = 16;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (pwdStr.length >= pwdLength) {
            pwdStr = [textField.text substringToIndex:pwdLength];
            return NO;
        }
    }
    else if (textField == self.inviteCodeTF) {
        NSString *inviteCodeStr = textField.text;
        NSInteger inviteLength = 8;
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (inviteCodeStr.length >= inviteLength) {
            inviteCodeStr = [textField.text substringToIndex:inviteLength];
            return NO;
        }
    }
    
    return YES;
}



#pragma mark - <method>
// 检测注册参数
- (BOOL)checkRegisterParameter
{
    NSString *phoneNumStr = self.phoneNumTF.text;
    NSString *passwordStr = self.passwordTF.text;
    NSString *inviteCodeStr = self.inviteCodeTF.text;
    if (![phoneNumStr isValidMobileNumber]) {
        [LSMaskTool showInfoMessage:@"手机号码格式错误"];
        return NO;
    }
    else if (![passwordStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"密码格式不正确"];
        return NO;
    }
    else if (self.inviteCodeTF.text.length != 0 && self.readAndAgreeButton.isSelected == YES) {
        if (![inviteCodeStr validateNickName]) {
            [LSMaskTool showInfoMessage:@"邀请码格式不正确 "];
            return NO;
        }
    }
    else if (self.readAndAgreeButton.isSelected == NO) {
        [LSMaskTool showInfoMessage:@"请阅读并同意用户注册协议"];
        return NO;
    }
    
    return YES;
}


#pragma mark <API>
- (void)setupKeyboard
{
    [self.phoneNumTF becomeFirstResponder];
}

@end
