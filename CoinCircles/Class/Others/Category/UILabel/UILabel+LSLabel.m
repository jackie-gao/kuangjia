//
//  UILabel+LSLabel.m
//  shanShuiHotel
//
//  Created by larson on 2019/6/21.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "UILabel+LSLabel.h"

@implementation UILabel (LSLabel)

- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size =  [self sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
    size.width = fmin(size.width, maxWidth);
    
    return size;
}

@end
