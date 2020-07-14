//
//  ZXKJMarketCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMarketCell.h"
#import "ZXKJMarketModel.h"

@interface ZXKJMarketCell ()
@property (weak, nonatomic) IBOutlet UILabel *tyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *increaseLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZXKJMarketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setModel:(ZXKJMarketModel *)model
{
    _model = model;
    
    self.tyleLabel.text = model.name;
    self.priceLabel.text = model.price;
    self.increaseLabel.text = model.change;
}

#pragma mark <setup separator line>
- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}

@end
