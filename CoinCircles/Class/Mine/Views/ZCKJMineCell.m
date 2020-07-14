//
//  ZCKJMineCell.m
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZCKJMineCell.h"
#import "ZCKJMineModel.h"

@interface ZCKJMineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZCKJMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}



#pragma mark - <setter>
- (void)setModel:(ZCKJMineModel *)model
{
    _model = model;
    
    self.kImageView.image = [UIImage imageNamed:model.imageNamed];
    self.kTitleLabel.text = model.title;
}


#pragma mark <setup separator line>
- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}

@end
