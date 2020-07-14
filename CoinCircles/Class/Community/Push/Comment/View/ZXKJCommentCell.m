//
//  ZXKJCommentCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommentCell.h"
#import "ZXKJCommentModel.h"
#import "LSPlaceholderTextView.h"
#import "LSChangeAvatarTool.h"

@interface ZXKJCommentCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet LSPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addImageBgViewHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstImageButtonHeightCons;
@property (weak, nonatomic) IBOutlet UIButton *firstImageButton;
@property (weak, nonatomic) IBOutlet UIButton *secondImageButton;
@property (weak, nonatomic) IBOutlet UIButton *thridImageButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,strong) NSMutableArray *images;
@property(nonatomic,strong) LSChangeAvatarTool *changeAvatarTool;

@end

@implementation ZXKJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    CGFloat buttonWidth = (kScreenWidth - 15 * 2) / 3;
    self.addImageBgViewHeightCons.constant = 27 + buttonWidth + 10;
    self.firstImageButtonHeightCons.constant = buttonWidth;
    
    self.textView.placeholder = @"这一刻有关你对区块链的想法";
    self.textView.placeholderColor = kRGBColor(153, 153, 153);
    self.textView.delegate = self;
    
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = kHomochromyColor(153).CGColor;
    self.textView.layer.cornerRadius = 10;
}



#pragma mark - <action>
#pragma mark <textField action>
- (IBAction)textFieldEditingAction {
    [self checkReleaseButtonState];
}

#pragma mark - <button action>
// 添加图片
- (IBAction)addImageButtonAction:(id)sender {
    kWeakSelf(self);
    self.changeAvatarTool = [[LSChangeAvatarTool alloc]init];
    [self.changeAvatarTool selectImageWithContainerVC:kContainerVC(self) completion:^(UIImage *image) {
        [weak_self.images addObject:image];
        switch (weak_self.images.count) {
            case 1:
                [weak_self.firstImageButton setImage:weak_self.images.firstObject forState:UIControlStateNormal];
                [weak_self.firstImageButton setBackgroundImage:nil forState:UIControlStateNormal];
                break;
                
            case 2:
                [weak_self.secondImageButton setImage:weak_self.images[1] forState:UIControlStateNormal];
                break;
                
            case 3:
                [weak_self.thridImageButton setImage:weak_self.images.lastObject forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }];
}


// 发布
- (IBAction)releaseButtonAction {
    if (![self checkReleaseParameter]) {
        return;
    }
    ZXKJCommentModel *model = ZXKJCommentModel.alloc.init;
    model.title = self.textField.text;
    model.content = self.textView.text;
    !self.releaseBlock ? : self.releaseBlock(model);
}


#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    [self checkReleaseButtonState];
}



#pragma mark <API>
- (void)setupKeyboard
{
    NSLog(@"啊咧咧");
    [self.textField becomeFirstResponder];
}



#pragma mark - <Method>
// 检测发布按钮的颜色
- (void)checkReleaseButtonState
{
    if (self.textField.text.length != 0 &&
        self.textView.text.length != 0) {
        self.sendButton.backgroundColor = kTintColor;
    }
    else {
        self.sendButton.backgroundColor = kHomochromyColor(153);
    }
}

// 检测内容参数
- (BOOL)checkReleaseParameter
{
    NSString *titleStr = self.textField.text;
    NSString *contentStr = self.textView.text;
    if (titleStr.length == 0) {
        [LSMaskTool showInfoMessage:@"请输入标题"];
        return NO;
    }
    else if (contentStr.length == 0) {
        [LSMaskTool showInfoMessage:@"请输入内容"];
        return NO;
    }
    else if ([titleStr isContainsSpecialCharactersAndChinese]) {
        [LSMaskTool showInfoMessage:@"不能包含特殊字符"];
        return NO;
    }
    else if ([contentStr isContainsEmoji]) {
        [LSMaskTool showInfoMessage:@"不能包含表情符号"];
        return NO;
    }
    
    return YES;
}



#pragma mark - <lazy>
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [@[] mutableCopy];
    }
    return _images;
}

@end
