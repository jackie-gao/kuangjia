//
//  ZCKJMineHeaderView.m
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZCKJMineHeaderView.h"
#import "ZXKJLoginViewController.h"
#import "ZXKJMineHeaderViewModel.h"
#import "ZXKJPersonInfoViewController.h"
#import "LSChangeAvatarTool.h"

@interface ZCKJMineHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *shadeBGImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property(nonatomic,strong) UIImage *gradientImage;
@property(nonatomic,strong) LSChangeAvatarTool *changeAvatarTool;

@end

@implementation ZCKJMineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupBasic];
}

#pragma mark - <setupBasic>
- (void)setupBasic
{
    // 设置一张渐变色图片
    self.shadeBGImageView.image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kRelativityHeight(190)) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
    
    // 个人信息
    UITapGestureRecognizer *infoTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personInfoClick)];
    [self addGestureRecognizer:infoTapGes];
    // 更换头像
    UITapGestureRecognizer *avatarTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarClick)];
    [self.iconImageView addGestureRecognizer:avatarTapGes];
    [infoTapGes requireGestureRecognizerToFail:avatarTapGes];
}



#pragma mark - <setter>
- (void)setHeaderViewModel:(ZXKJMineHeaderViewModel *)headerViewModel
{
    _headerViewModel = headerViewModel;
    
    if (kUserDefaultsGetValueWithKey(ZCKJTokenKey)) {
        [self setupLoginStatusInfo];
    }
    else {
        [self setupNotLoggedInInfo];
    }
}



#pragma mark - <GestureAction>
// 个人信息
- (void)personInfoClick
{
    // 检测是否登录
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    kWeakSelf(self);
    ZXKJPersonInfoViewController *personVC = [[ZXKJPersonInfoViewController alloc]init];
    personVC.modifySuccessBlock = ^(UIImage * _Nonnull image) {
        weak_self.nickNameLabel.text = kUserDefaultsGetStringWithKey(ZCKJNicknameKey);
        if (image) {
            weak_self.iconImageView.image = image;
        }
    };
    [kContainerVC(self).navigationController pushViewController:personVC animated:YES];
}

// 更换头像
- (void)avatarClick
{
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    kWeakSelf(self);
    LSChangeAvatarTool *changeAvatar = [[LSChangeAvatarTool alloc]init];
    [changeAvatar changeAvatarWithContainerVC:[self getCurrentViewForContainerController] completion:^(UIImage *image) {
        UIImage *circleImage = [image circleImage];
        [UIImage SaveImageToLocal:circleImage imageName:ZCKJLocatAvatarKey];
        weak_self.iconImageView.image = circleImage;
    }];
    self.changeAvatarTool = changeAvatar;
}



#pragma mark - <method>
/// 设置登录状态信息
- (void)setupLoginStatusInfo
{
    if ([UIImage LocalHaveImage:ZCKJLocatAvatarKey]) {
        self.iconImageView.image = [UIImage GetLocationImageFromImageName:ZCKJLocatAvatarKey];
    }
    else {
        self.iconImageView.image = [UIImage imageNamed:self.headerViewModel.avatar];
    }
    self.phoneNumLabel.text = self.headerViewModel.mobile;
    self.nickNameLabel.text = self.headerViewModel.nickname;
}

/// 设置未登录状态信息
- (void)setupNotLoggedInInfo
{
    self.iconImageView.image = [UIImage imageNamed:@"Icon-60"];
    self.phoneNumLabel.text = @"登录/注册";
    self.nickNameLabel.text = @"您还未登录哦！";
}

@end
