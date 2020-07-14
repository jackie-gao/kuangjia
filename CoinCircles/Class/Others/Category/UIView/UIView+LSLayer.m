//
//  UIView+LSLayer.m
//  zhiYouLive
//
//  Created by larson on 2019/4/28.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import "UIView+LSLayer.h"

@implementation UIView (LSLayer)

- (void)designationWithRadius:(CGFloat)radius corner:(UIRectCorner)corner
{
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

@end
