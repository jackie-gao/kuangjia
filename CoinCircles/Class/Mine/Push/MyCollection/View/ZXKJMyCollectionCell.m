//
//  ZXKJMyCollectionCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMyCollectionCell.h"
#import "ZXKJNewsModel.h"

@interface ZXKJMyCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZXKJMyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}


@end
