//
//  ZXKJMarketSectionHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMarketSectionHeaderView.h"
#import "ZXKJMarketSectionModel.h"
#import "ZXKJRankingDetailsViewController.h"

@interface ZXKJMarketSectionHeaderView ()
@property(nonatomic,strong) UIView *topView;
/** 排行榜*/
@property(nonatomic,strong) UILabel *rankingLabel;
@property(nonatomic,strong) UIButton *moreButton;
@property(nonatomic,strong) UIView *bottomView;
/** 币种*/
@property(nonatomic,strong) UILabel *typeLabel;
/** 指数*/
@property(nonatomic,strong) UILabel *indexLabel;
/** 涨跌*/
@property(nonatomic,strong) UILabel *changeLabel;
@property(nonatomic,strong) UIView *bottomLine;

@end

@implementation ZXKJMarketSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
 if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     [self addChildView];
   }
    return self;
}



+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    NSString *ID = @"heardView";
    ZXKJMarketSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[ZXKJMarketSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
}



- (void)addChildView
{
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.bottomView];
}



#pragma mark - <setter>
- (void)setSectionModel:(ZXKJMarketSectionModel *)sectionModel
{
    _sectionModel = sectionModel;
    
    self.rankingLabel.text = sectionModel.title;
    self.typeLabel.text = sectionModel.type;
    self.indexLabel.text = sectionModel.index;
    self.changeLabel.text = sectionModel.change;
}



#pragma mark - <action>
- (void)moreButtonAction
{
    ZXKJRankingDetailsViewController *rankingDetailsVC = ZXKJRankingDetailsViewController.alloc.init;
    rankingDetailsVC.datas = self.sectionModel.more;
    rankingDetailsVC.kTitle = self.sectionModel.title;
    [kContainerVC(self).navigationController pushViewController:rankingDetailsVC animated:YES];
}



#pragma mark - <lazy>
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        _topView.backgroundColor = kWhiteColor;
        
        [_topView addSubview:self.rankingLabel];
        [_topView addSubview:self.moreButton];
    }
    return _topView;
}

- (UILabel *)rankingLabel {
    if (!_rankingLabel) {
        _rankingLabel = UILabel.alloc.init;
        _rankingLabel.LS_x = 10;
        _rankingLabel.LS_width = 95;
        _rankingLabel.LS_height = 20;
        _rankingLabel.LS_centerY = self.topView.LS_centerY;
        _rankingLabel.textColor = kRGBColor(51, 51, 51);
        _rankingLabel.font = kFont(16);
        _rankingLabel.text = @"---";
    }
    return _rankingLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.LS_width = 85;
        _moreButton.LS_height = 30;
        _moreButton.LS_centerY = self.topView.LS_centerY;
        _moreButton.LS_x = kScreenWidth - 10 - _moreButton.LS_width;
        [_moreButton setTitle:@"查看更多>" forState:UIControlStateNormal];
        [_moreButton setTitleColor:kRGBColor(51, 51, 51) forState:UIControlStateNormal];
        _moreButton.titleLabel.font = kFont(16);
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreButton;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.LS_height, kScreenWidth, 35)];
        _bottomView.backgroundColor = kWhiteColor;
        
        [_bottomView addSubview:self.typeLabel];
        [_bottomView addSubview:self.indexLabel];
        [_bottomView addSubview:self.changeLabel];
        [_bottomView addSubview:self.bottomLine];
    }
    return _bottomView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = UILabel.alloc.init;
        _typeLabel.LS_x = 10;
        _typeLabel.LS_width = 120;
        _typeLabel.LS_height = 20;
        _typeLabel.mj_y = (self.bottomView.LS_height - _typeLabel.LS_height) / 2;
        _typeLabel.textColor = kRGBColor(153, 153, 153);
        _typeLabel.font = kFont(13);
        _typeLabel.text = @"---";
    }
    return _typeLabel;
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = UILabel.alloc.init;
        _indexLabel.LS_width = 85;
        _indexLabel.LS_height = 20;
        _indexLabel.LS_x = self.changeLabel.LS_x - 25 - _indexLabel.LS_width;
        _indexLabel.LS_y = self.changeLabel.LS_y;
        _indexLabel.textColor = kRGBColor(153, 153, 153);
        _indexLabel.font = kFont(13);
        _indexLabel.text = @"---";
        _indexLabel.textAlignment = NSTextAlignmentRight;
    }
    return _indexLabel;
}

- (UILabel *)changeLabel {
    if (!_changeLabel) {
        _changeLabel = UILabel.alloc.init;
        _changeLabel.LS_width = 85;
        _changeLabel.LS_height = 20;
        _changeLabel.mj_y = (self.bottomView.LS_height - _changeLabel.LS_height) / 2;
        _changeLabel.LS_x = kScreenWidth - 10 - _changeLabel.LS_width;
        _changeLabel.textColor = kRGBColor(153, 153, 153);
        _changeLabel.font = kFont(13);
        _changeLabel.text = @"---";
        _changeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _changeLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = UIView.alloc.init;
        _bottomLine.LS_x = 0;
        _bottomLine.LS_width = kScreenWidth;
        _bottomLine.LS_height = 0.5;
        _bottomLine.LS_y = self.bottomView.LS_height - _bottomLine.LS_height;
        _bottomLine.backgroundColor = kHomochromyColor(235);
    }
    return _bottomLine;
}

@end
