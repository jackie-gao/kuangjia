//
//  UILabel+LSLabel.h
//  shanShuiHotel
//
//  Created by larson on 2019/6/21.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LSLabel)

/// 根据宽度获取size
- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth;

@end
