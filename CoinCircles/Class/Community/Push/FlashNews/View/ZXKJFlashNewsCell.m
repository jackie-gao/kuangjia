//
//  ZXKJFlashNewsCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJFlashNewsCell.h"
#import "ZXKJFlashNewsModel.h"

@interface ZXKJFlashNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation ZXKJFlashNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark - <setter>
- (void)setModel:(ZXKJFlashNewsModel *)model
{
    _model = model;
    
    self.timeLabel.text = model.gmtRelease;
    self.contentLabel.text = model.content;
    
    self.topLine.hidden = model.isHideTopLine;
}

@end
