//
//  LSAbstractDotView.h
//  collectionView轮播图
//
//  Created by larson on 2019/2/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSAbstractDotView : UIView

/**
 * 采取哪种状态(活动是当前页面；不活动，不是当前页面)
 *
 *  @param active 视图是否活动
 */
- (void)changeActivityState:(BOOL)active;

@end
