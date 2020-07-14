//
//  ZXKJNewsCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/4.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsCell.h"
#import "ZXKJNewsModel.h"

@interface ZXKJNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ZXKJNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}



#pragma mark - <setter>
- (void)setModel:(ZXKJNewsModel *)model
{
    _model = model;
    
    [self.kImageView setImageWithUrl:model.coverUrl];
    self.kTitleLabel.text = model.title;
    self.sourceLabel.text = model.source;
    self.timeLabel.text = [NSString stringWithFormat:@"%u次阅读",arc4random_uniform(20000)];
}

@end
