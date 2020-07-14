//
//  UIView+LSLayer.h
//  zhiYouLive
//
//  Created by larson on 2019/4/28.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

// --------------- layer的一些设置 --------------- //

#import <UIKit/UIKit.h>

@interface UIView (LSLayer)

/**
 * 设置指定位置的圆角(使用自动布局，需要在layoutsubviews中使用)
 *
 * @param radius 圆角尺寸
 * @param corner 圆角位置
 */
- (void)designationWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

@end
