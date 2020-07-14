//
//  ZXKJNewsDetailsCell.m
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsDetailsCell.h"
#import "ZXKJNewsDetailsModel.h"

@interface ZXKJNewsDetailsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiemLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation ZXKJNewsDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


#pragma mark - <setter>
- (void)setModel:(ZXKJNewsDetailsModel *)model
{
    _model = model;
    
    if ([UIImage GetLocationImageFromImageName:model.imageNamed]) {
        self.kImageView.image = [UIImage GetLocationImageFromImageName:model.imageNamed];
    }
    else {
        self.kImageView.image = [UIImage imageNamed:kUserDefaultsGetStringWithKey(ZCKJAvatarKey)];
    }
    
    self.nicknameLabel.text = model.nickname;
    self.tiemLabel.text = model.time;
    self.contentLabel.text = model.content;
}

- (void)setSeparatorLineHidden:(BOOL)separatorLineHidden
{
    _separatorLineHidden = separatorLineHidden;
    
    self.separatorLine.hidden = self.isSeparatorLineHidden;
}



#pragma mark - <action>
- (IBAction)deleteCommentButtonAction {
    UITableView *tableView = (UITableView *)self.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    !self.deleteCommentBlock ? : self.deleteCommentBlock(indexPath.row);
}

@end
