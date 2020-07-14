//
//  ZXKJCommunityHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityHeaderView.h"
#import "ZXKJFlashNewsViewController.h"         // 快讯
#import "ZXKJHeadlinesViewController.h"         // 头条资讯
#import "ZXKJCelebrityViewController.h"         // 名人榜

@interface ZXKJCommunityHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstLine;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondLine;
@property (weak, nonatomic) IBOutlet UILabel *thirdNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *headlineInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIButton *celebrityButton;
@property (weak, nonatomic) IBOutlet UIImageView *leftLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightLineImageView;

/** 竖*/
@property(nonatomic,strong) UIImage *verticalImage;
/** 横*/
@property(nonatomic,strong) UIImage *horizontalImage;
/** 按钮图片*/
@property(nonatomic,strong) UIImage *buttonBGImage;

@end

@implementation ZXKJCommunityHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.firstLine.image = self.verticalImage;
    self.secondLine.image = self.verticalImage;
    self.leftLineImageView.image = self.horizontalImage;
    self.rightLineImageView.image = self.horizontalImage;
    [self.headlineInfoButton setBackgroundImage:self.buttonBGImage forState:UIControlStateNormal];
    [self.flashButton setBackgroundImage:self.buttonBGImage forState:UIControlStateNormal];
    [self.celebrityButton setBackgroundImage:self.buttonBGImage forState:UIControlStateNormal];
}



#pragma mark - <action>
// 快讯
- (IBAction)flashNewButtonAction {
    ZXKJFlashNewsViewController *flashNewsVC = ZXKJFlashNewsViewController.alloc.init;
    [kContainerVC(self).navigationController pushViewController:flashNewsVC animated:YES];
}

// 头条资讯
- (IBAction)headlinesButtonAction {
    ZXKJHeadlinesViewController *headlinesVC = ZXKJHeadlinesViewController.alloc.init;
    [kContainerVC(self).navigationController pushViewController:headlinesVC animated:YES];
}

// 名人榜
- (IBAction)celebrityButtonAction:(id)sender {
    ZXKJCelebrityViewController *celebrityVC = ZXKJCelebrityViewController.alloc.init;
    [kContainerVC(self).navigationController pushViewController:celebrityVC animated:YES];
}

#pragma mark - <lazy>
- (UIImage *)verticalImage
{
    if (!_verticalImage) {
        _verticalImage = [UIImage gradientImageWithBounds:CGRectMake(0, 0, 2, 30) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:0];
        
    }
    return _verticalImage;
}

- (UIImage *)horizontalImage
{
    if (!_horizontalImage) {
        CGFloat width = (kScreenWidth - 25 * 2 - 30 * 2 - 35) / 2;
        _horizontalImage = [UIImage gradientImageWithBounds:CGRectMake(0, 0, width, 2) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
    }
    return _horizontalImage;
}

- (UIImage *)buttonBGImage
{
    if (!_buttonBGImage) {
        CGFloat width = (kScreenWidth - 20 * 4) / 3;
        _buttonBGImage = [UIImage gradientImageWithBounds:CGRectMake(0, 0, width, self.headlineInfoButton.LS_height) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
    }
    return _buttonBGImage;
}

@end
