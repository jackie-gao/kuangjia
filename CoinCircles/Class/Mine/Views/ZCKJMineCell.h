//
//  ZCKJMineCell.h
//  Blockchain
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCKJMineModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZCKJMineCell : UITableViewCell
@property(nonatomic,strong) ZCKJMineModel *model;
@property(nonatomic,assign, getter=isSeparatorLineHidden) BOOL separatorLineHidden;

@end

NS_ASSUME_NONNULL_END
