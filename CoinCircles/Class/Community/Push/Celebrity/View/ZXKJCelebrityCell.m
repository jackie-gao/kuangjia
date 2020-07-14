//
//  ZXKJCelebrityCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCelebrityCell.h"
#import "ZXKJCelebrityModel.h"

@interface ZXKJCelebrityCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IntroductionLabel;

@end

@implementation ZXKJCelebrityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark - <setter>
- (void)setModel:(ZXKJCelebrityModel *)model
{
    _model = model;
    
    [self.kImageView setImageWithUrl:model.image];
    self.nameLabel.text = model.name;
    self.IntroductionLabel.text = model.title;
}

@end
