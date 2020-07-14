//
//  ZXKJNewsHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsHeaderView.h"
#import "LSCycleScrollView.h"

@interface ZXKJNewsHeaderView ()
@property (weak, nonatomic) IBOutlet LSCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 中文名称
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel;
// 市值
@property (weak, nonatomic) IBOutlet UILabel *marketValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
// 涨跌幅
@property (weak, nonatomic) IBOutlet UILabel *fluctuateLabel;
@property(nonatomic,strong) NSMutableArray *imagges;

@end

@implementation ZXKJNewsHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
//    for (NSInteger i = 0; i < 10; i++) {
//        UIImage *image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth - 20, kRelativityHeight(140)) andColors:@[kRGBColor(30, 180, 165), kRGBColor(30, 170, 190)] andGradientType:1];
//        UIImage *newImage = [image addText:@"123" textFontSize:13 color:kWhiteColor];
//        [self.imagges addObject:newImage];
//    }
//
    self.bannerView.showPageControl = NO;
    self.bannerView.autoScrollTimeInterval = 5;
    self.bannerView.localizaationImageNamesGroup = self.imagges;
}



#pragma mark - <lazy>
- (NSMutableArray *)imagges
{
    if (!_imagges) {
        _imagges = [@[] mutableCopy];
        for (NSInteger i = 0; i < 5; i++) {
            [_imagges addObject:[NSString stringWithFormat:@"banner_%ld", i + 1]];
        }
    }
    return _imagges;
}

@end
