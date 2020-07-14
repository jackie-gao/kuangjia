//
//  ZXKJPersonInfoCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJPersonInfoCell.h"
#import "ZXKJPersonInfoModel.h"
#import "LSChangeAvatarTool.h"

@interface ZXKJPersonInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *avatrBGView;
@property (weak, nonatomic) IBOutlet UIImageView *avatrImageView;
@property (weak, nonatomic) IBOutlet UIView *nickNameBGView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *phoneNumBGView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UIView *emailBGView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailLabelRightCons;
@property (weak, nonatomic) IBOutlet UIImageView *emailIndicatorImage;
@property(nonatomic,strong) LSChangeAvatarTool *changeAvatarTool;

@end

@implementation ZXKJPersonInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    // 更换头像
    UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarGestureHandle)];
    [self.avatrBGView addGestureRecognizer:avatarTap];
    // 昵称
    UITapGestureRecognizer *nicknameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nicknameGestureHandle)];
    [self.nickNameBGView addGestureRecognizer:nicknameTap];
    // 邮箱
    UITapGestureRecognizer *emailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emailGestureHandle)];
    [self.emailBGView addGestureRecognizer:emailTap];
    // 执行后面的手势，放弃前面的手势
    [avatarTap requireGestureRecognizerToFail:nicknameTap];
    [nicknameTap requireGestureRecognizerToFail:emailTap];
}



#pragma mark - <setter>
- (void)setModel:(ZXKJPersonInfoModel *)model
{
    _model = model;
    
    if ([UIImage LocalHaveImage:ZCKJLocatAvatarKey]) {
        self.avatrImageView.image = [UIImage GetLocationImageFromImageName:ZCKJLocatAvatarKey];
    }
    else {
        self.avatrImageView.image = [UIImage imageNamed:model.avatar];
    }
    self.nickNameLabel.text = model.nickname;
    self.phoneNumLabel.text = model.mobile;
    
    if (model.email.length) {
        self.emailLabel.text = model.email;
        self.emailIndicatorImage.hidden = YES;
        self.emailLabelRightCons.constant = 11;
        self.emailBGView.userInteractionEnabled = NO;
        self.emailLabel.textColor = kHomochromyColor(51);
    } else {
        self.emailLabel.text = @"待添加";
        self.emailIndicatorImage.hidden = NO;
        self.emailLabelRightCons.constant = 25;
        self.emailBGView.userInteractionEnabled = YES;
        self.emailLabel.textColor = kHomochromyColor(153);
    }
}



#pragma mark - <action>
#pragma mark <gestureAction>
// 头像
- (void)avatarGestureHandle
{
    kWeakSelf(self);
    LSChangeAvatarTool *changeAvatar = [[LSChangeAvatarTool alloc]init];
    [changeAvatar changeAvatarWithContainerVC:[self getCurrentViewForContainerController] completion:^(UIImage *image) {
        UIImage *circleImage = [image circleImage];
        [UIImage SaveImageToLocal:circleImage imageName:ZCKJLocatAvatarKey];
        weak_self.avatrImageView.image = circleImage;
        !self.avatrBlock ? : self.avatrBlock(circleImage);
    }];
    self.changeAvatarTool = changeAvatar;
}

// 昵称
- (void)nicknameGestureHandle
{
    kWeakSelf(self);
    [LSAlertController AlertStyleAndTextFieldWithTitle:@"请设置您的昵称" message:nil textPlaechodle:@"请输入昵称" fromVC:kContainerVC(self) completeBlock:^(NSString *inputValue) {
        if (![inputValue validateNickName]) {
            [LSMaskTool showInfoMessage:@"昵称不能包含特殊字符和表情"];
            return;
        }
        else if ([inputValue isEqualToString:kUserDefaultsGetStringWithKey(ZCKJNicknameKey)]) {
            [LSMaskTool showInfoMessage:@"重复设置"];
            return;
        }
        !weak_self.nickNameBlock ? : self.nickNameBlock(inputValue);
    }];
}

// 邮箱
- (void)emailGestureHandle
{
    kWeakSelf(self);
    [LSAlertController AlertStyleAndTextFieldWithTitle:@"请设置您常用的电子邮箱" message:nil textPlaechodle:@"请输入电子邮箱" fromVC:kContainerVC(self) completeBlock:^(NSString *inputValue) {
        if (![inputValue isValidEmail]) {
            [LSMaskTool showInfoMessage:@"邮箱格式不正确"];
            return;
        }
        !weak_self.emailBlock ? : weak_self.emailBlock(inputValue);
    }];
}

@end
