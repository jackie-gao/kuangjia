//
//  ZXKJCommunityCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityCell.h"
#import "ZXKJCommunityModel.h"
#import "ZXKJCommunityDetailsViewController.h"

@interface ZXKJCommunityCell ()
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureBgViewHeightCons;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thridImageView;

@end

@implementation ZXKJCommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.pictureBgViewHeightCons.constant = (kScreenWidth - 15 * 4) / 3;
}



#pragma mark - <setter>
- (void)setModel:(ZXKJCommunityModel *)model
{
    _model = model;

    self.kTitleLabel.text = model.title;
    self.contentLabel.text = model.content;
    for (NSInteger i = 0; i < model.images.count; i++) {
        if (i == 0) {
            self.firstImageView.image = [UIImage imageNamed:model.images[i]];
        }
        else if (i == 1) {
            self.secondImageView.image = [UIImage imageNamed:model.images[i]];
        }
        else if (i == 2) {
            self.thridImageView.image = [UIImage imageNamed:model.images[i]];
        }
    }
    self.timeLabel.text = model.time;
}



#pragma mark - <action>
// 屏蔽
- (IBAction)shieldButtonAction {
    
    kWeakSelf(self);
    [LSAlertController AlertStyleAndTextFieldWithTitle:@"确定屏蔽此内容吗" message:nil fromVC:kContainerVC(self) completeBlock:^(NSString *inputValue) {
        UITableView *tableView = (UITableView *)self.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        !weak_self.shieldBlock ? : weak_self.shieldBlock(indexPath.row);
        [LSMaskTool showMessage:@"我们将减少此类内容的推送"];
    }];
}

// 评论
- (IBAction)commentButtonAction {
    ZXKJCommunityDetailsViewController *communityDetailsVC = ZXKJCommunityDetailsViewController.alloc.init;
    communityDetailsVC.model = self.model;
    [kContainerVC(self).navigationController pushViewController:communityDetailsVC animated:YES];
}

// 举报
- (IBAction)reportButtonAction {
    kWeakSelf(self);
    [LSAlertController AlertStyleAndTextFieldWithTitle:nil titleColor:nil titleFont:nil message:@"此内容设计政治、赌博、诈骗、反动言论、裸露、色情、和猥亵等令人反感的信息" messageColor:kHomochromyColor(51) messageFont:kFont(15) leftActionText:@"取消" leftActionColor:nil rightActionText:@"举报" rightActionColor:kTintColor actionFont:kFont(14) fromVC:kContainerVC(self) leftActionHandleBlock:nil rightActionHandleBlock:^{
        UITableView *tableView = (UITableView *)self.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        !weak_self.reportBlock ? : weak_self.reportBlock(indexPath.row);
        [LSMaskTool showMessage:@"该内容将重新进行审核"];
    }];
}

@end
