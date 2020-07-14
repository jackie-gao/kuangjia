//
//  LSNewFeatureCell.m
//
//  Created by larson on 2017/10/26.
//  Copyright © 2017年 larson. All rights reserved.
//


#import "LSGuideCell.h"
#import "ZXKJTabBarController.h"

@interface LSGuideCell ()

@property(nonatomic,weak) UIImageView *imageV;

/** 开始按钮*/
@property(nonatomic,weak) UIButton *startButton;

@end

@implementation LSGuideCell



#pragma mark - <setter>
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageV.image = image;
}


#pragma mark - <action>
- (void)start
{
    // 保存最新版本
    kUserDefaultsSetValueAndKey(kAppReleaseVersion, ZCKJGuidePageVersionKey);
    
    kRootViewController = [[ZXKJTabBarController alloc]init];
    // 转场动画
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = @"fade";
    [kKeyWindow.layer addAnimation:animation forKey:nil];
}



#pragma mark - <API>
- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount
{
    // 给最后一个cell添加按钮
    if (indexPath.item == pagesCount - 1) {
        [self startButton];
        self.startButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
        [self.startButton removeFromSuperview];
    }
}



#pragma mark - <lazy>
- (UIImageView *)imageV
{
    if (!_imageV) {
        CGFloat height = kRelativityHeight(500);
        CGFloat y = kHeightNavigationBar;
        if (kScreenWidth == 320) {
            y -= 20;
        }
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(0, y, kScreenWidth, height);
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
    }
    
    return _imageV;
}

- (UIButton *)startButton
{
    if (!_startButton) {
        CGFloat x = 63;
        CGFloat width = kScreenWidth - 2 * x;
        CGFloat height = 40;
        CGFloat y = kScreenHeight - kHeightBottomSafe - 36 - height;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, width, height);
        button.backgroundColor = kRGBColor(200, 255, 231);
        [button setTitle:@"立即体验" forState:UIControlStateNormal];
        [button setTitleColor:kRGBColor(12, 106, 65) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        button.center = kPoint(self.LS_width * 0.5, self.LS_height * 0.9);
        [self.contentView addSubview:button];
        button.layer.cornerRadius = height / 2;
        self.startButton = button;
    }
    return _startButton;
}

@end





