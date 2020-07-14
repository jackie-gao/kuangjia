//
//  ZXKJAttentionCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJAttentionCell.h"
//#import "ZXKJAttentionModel.h"
#import "ZXKJCelebrityModel.h"

@interface ZXKJAttentionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@end

@implementation ZXKJAttentionCell

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
    self.introductionLabel.text = model.title;
}

@end
