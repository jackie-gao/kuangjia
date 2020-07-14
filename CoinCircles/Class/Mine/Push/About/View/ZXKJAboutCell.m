//
//  ZXKJAboutCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJAboutCell.h"

@interface ZXKJAboutCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ZXKJAboutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setupBasic>
- (void)setupBasic
{
    // 设置一张渐变色图片
    self.bgImageView.image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kRelativityHeight(190)) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
}

@end
