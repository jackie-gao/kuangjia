//
//  ZXKJRankingDetailsSectionHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRankingDetailsSectionHeaderView.h"
#import "ZXKJRankingDetailsSectionModel.h"

@interface ZXKJRankingDetailsSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;

@end

@implementation ZXKJRankingDetailsSectionHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}



#pragma mark - <setter>
- (void)setSectionModel:(ZXKJRankingDetailsSectionModel *)sectionModel
{
    _sectionModel = sectionModel;
    
    self.typeLabel.text = sectionModel.type;
    self.indexLabel.text = sectionModel.index;
    self.changeLabel.text = sectionModel.change;
}

@end
