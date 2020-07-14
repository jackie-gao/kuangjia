//
//  ZXKJHeadlinesCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJHeadlinesCell.h"
#import "ZXKJHeadlinesModel.h"

@interface ZXKJHeadlinesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ZXKJHeadlinesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark - <setter>
- (void)setModel:(ZXKJHeadlinesModel *)model
{
    _model = model;
    
    [self.kImageView setImageWithUrl:model.coverUrl];
    self.kTitleLabel.text = model.title;
    self.sourceLabel.text = model.source;
    self.timeLabel.text = [NSString stringWithFormat:@"%u次阅读",arc4random_uniform(20000)];
}

@end
