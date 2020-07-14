//
//  ZXKJModifyLoginPasswordCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJModifyLoginPasswordCell.h"

@interface ZXKJModifyLoginPasswordCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPWDTextField;
@property (weak, nonatomic) IBOutlet UITextField *novelPWDTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmModifyButton;

@end

@implementation ZXKJModifyLoginPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.oldPWDTextField.delegate = self;
    self.novelPWDTextField.delegate = self;
    [self.oldPWDTextField addTarget:self action:@selector(passwordTFInputState:) forControlEvents:UIControlEventEditingChanged];
    [self.novelPWDTextField addTarget:self action:@selector(passwordTFInputState:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark - <action>
#pragma mark - <buttonAction>
// 确定更换
- (IBAction)confirmModifyReplacementButtonAction {
    NSString *oldPasswordStr = self.oldPWDTextField.text;
    NSString *novelPasswordStr = self.novelPWDTextField.text;
    if (![oldPasswordStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"旧密码格式错误"];
        return;
    }
    else if (![novelPasswordStr isValidAlphaNumberPassword]) {
        [LSMaskTool showInfoMessage:@"新密码格式错误"];
        return;
    }
    else if ([oldPasswordStr isEqualToString:novelPasswordStr]) {
        [LSMaskTool showInfoMessage:@"重复设置"];
        return;
    }
    
    !self.modifyLoginPasswordBlock ? : self.modifyLoginPasswordBlock(oldPasswordStr, novelPasswordStr);
}



#pragma mark - <textFieldAction>
- (void)passwordTFInputState:(UITextField *)textField
{
    // 登录按钮颜色
    if (self.oldPWDTextField.text.length != 0 && self.novelPWDTextField.text.length != 0) {
        self.confirmModifyButton.backgroundColor = kTintColor;
    } else {
        self.confirmModifyButton.backgroundColor = kRGBColor(153, 153, 153);
    }
}



#pragma mark - <UITextFieldDelegate>
// 限制输入的位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *pwdStr = textField.text;
    NSInteger pwdLength = 16;
    if (range.length == 1 && string.length == 0) {
        return YES;
    } else if (pwdStr.length >= pwdLength) {
        pwdStr = [textField.text substringToIndex:pwdLength];
        return NO;
    }
    
    return YES;
}



#pragma mark - <API>
- (void)setupKeyboard
{
    [self.oldPWDTextField becomeFirstResponder];
}

@end
