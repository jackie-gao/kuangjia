//
//  ZXKJLoginBaseViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJLoginBaseViewController.h"

@interface ZXKJLoginBaseViewController ()

@end

@implementation ZXKJLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWhiteColor;
    self.customNavigationBar.title = @"";
    [self.customNavigationBar LS_setBottomLineHidden:YES];
    self.customNavigationBar.barBackgroundColor = kWhiteColor;
    self.customNavigationBar.titleLabelColor = kRGBColor(51, 51, 51);
    [self.customNavigationBar LS_setLeftButtonWithImage:[UIImage imageNamed:@"nav_back"]];
}

@end
