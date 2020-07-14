//
//  ZXKJFeedbackCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJFeedbackCell.h"
#import "LSPlaceholderTextView.h"

@interface ZXKJFeedbackCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet LSPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ZXKJFeedbackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.textView.placeholder = @"请填写您对本产品的使用建议与反馈！";
    self.textView.placeholderColor = kRGBColor(153, 153, 153);
    self.textView.delegate = self;
}



#pragma mark - <action>
// 提交
- (IBAction)submitButtonAction {
    NSString *text = self.textView.text;
    if ([text isBlack]) {
        [LSMaskTool showInfoMessage:@"不能包含空格"];
        return;
    }
    else if ([text isContainsEmoji]) {
        [LSMaskTool showInfoMessage:@"不能包含表情符号"];
        return;
    }
    else if (text.length < 5) {
        [LSMaskTool showInfoMessage:@"评论最少为5个字"];
        return;
    }
    else if (text.length > 500) {
        [LSMaskTool showInfoMessage:@"评论不能超过500个字"];
        return;
    }
    
    !self.submitBlock ? : self.submitBlock(text);
}



#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.submitButton.backgroundColor = (textView.text.length >= 5 ? kTintColor : kRGBColor(153, 153, 153));
    
    if (textView.text.length <= 500) {
        self.wordCountLabel.textColor = kRGBColor(153, 153, 153);
    }else{
        self.wordCountLabel.textColor = kRedColor;
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%zd/500", textView.text.length];
}



#pragma mark - <method>
#pragma mark <API>
- (void)setupKeyboard
{
    [self.textView becomeFirstResponder];
}


// 清空textView
- (void)emputTextView
{
    UITextRange *textRange = [self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument];
    [self.textView replaceRange:textRange withText:@""];
}

@end
