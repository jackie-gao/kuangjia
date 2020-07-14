//
//  ZXKJSettingCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJSettingCell.h"
#import "ZXKJSettingModel.h"

@interface ZXKJSettingCell ()
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kDetailsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZXKJSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}



#pragma mark - <setter>
- (void)setModel:(ZXKJSettingModel *)model
{
    _model = model;
    
    self.kTitleLabel.text = model.title;
    if (model.isShowIndicator) {
        self.kDetailsLabel.hidden = YES;
        self.indicatorImageView.hidden = NO;
    }
    else {
        self.kDetailsLabel.hidden = NO;
        self.indicatorImageView.hidden = YES;
        self.kDetailsLabel.text = [LSSaveTool getCacheSize];
    }
}

// setup separator line
- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}

@end
