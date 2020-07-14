//
//  ZXKJCelebrityDetailsCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCelebrityDetailsCell.h"
#import "ZXKJCelebrityModel.h"

@interface ZXKJCelebrityDetailsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *conentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightCons;

@end

@implementation ZXKJCelebrityDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark - <setter>
- (void)setModel:(ZXKJCelebrityModel *)model
{
    _model = model;
    
    self.conentLabel.text = self.model.content;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.kImageView.image = image;
    self.imageHeightCons.constant = image.size.height;
}

@end
