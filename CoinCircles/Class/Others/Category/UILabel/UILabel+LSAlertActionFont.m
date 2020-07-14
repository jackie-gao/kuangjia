//
//  UILabel+LSAlertActionFont.m
//  shanShuiHotel
//
//  Created by larson on 2019/7/3.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "UILabel+LSAlertActionFont.h"

@implementation UILabel (LSAlertActionFont)

- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if (appearanceFont) {
        [self setFont:appearanceFont];
    }
}


- (UIFont *)appearanceFont
{
    return self.font;
}

@end
