//
//  ZXKJRankingDetailsCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRankingDetailsCell.h"
#import "ZXKJRankingDetailsModel.h"

@interface ZXKJRankingDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLaebl;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZXKJRankingDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark - <setter>
- (void)setModel:(ZXKJRankingDetailsModel *)model
{
    _model = model;
    
    self.typeLabel.text = model.name;
    self.indexLabel.text = model.price;
    self.changeLaebl.text = model.change;
}

#pragma mark <setup separator line>
- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}

@end
