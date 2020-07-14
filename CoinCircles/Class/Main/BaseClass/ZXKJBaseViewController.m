//
//  ZXKJBaseViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJBaseViewController.h"

@interface ZXKJBaseViewController ()

@end

@implementation ZXKJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kControllerBgColor;
    
    [self setupNavigationBar];
}



#pragma mark - <setupNavigationBar>
- (void)setupNavigationBar
{
    self.navigationController.navigationBar.hidden = YES;
    self.customNavigationBar.titleLabelColor = kWhiteColor;
    // 生成一张渐变色图片
//    UIImage *image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kHeightNavigationBar) andColors:@[kRGBColor(30, 180, 165), kRGBColor(30, 170, 190)] andGradientType:1];
    UIImage *image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kHeightNavigationBar) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
    self.customNavigationBar.barBackgroundImage = image;
    [self.customNavigationBar LS_setBottomLineHidden:YES];
    
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavigationBar LS_setLeftButtonWithImage:[UIImage imageNamed:@"nav_white_back"]];
    }
    
    [self.view addSubview: self.customNavigationBar];
}



#pragma mark - <lazy>
- (LSCustomNavigationBar *)customNavigationBar
{
    if (!_customNavigationBar) {
        _customNavigationBar = [LSCustomNavigationBar customNavigationBar];
    }
    return _customNavigationBar;
}

@end
