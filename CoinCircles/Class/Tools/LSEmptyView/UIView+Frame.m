//
//  UIView+LSExtension.m
//
//  Created by larson on 2016/1/1.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - <快捷设置frame>
// x
- (CGFloat)LS_x
{
    return self.frame.origin.x;
}
- (void)setLS_x:(CGFloat)LS_x
{
    CGRect frame = self.frame;
    frame.origin.x = LS_x;
    self.frame = frame;
}

// y
- (CGFloat)LS_y
{
    return self.frame.origin.y;
}
- (void)setLS_y:(CGFloat)LS_y
{
    CGRect frame = self.frame;
    frame.origin.y = LS_y;
    self.frame = frame;
}

// width
- (CGFloat)LS_width
{
    return self.frame.size.width;
}
- (void)setLS_width:(CGFloat)LS_width
{
    CGRect frame = self.frame;
    frame.size.width = LS_width;
    self.frame = frame;
}

// height
- (CGFloat)LS_height
{
    return self.frame.size.height;
}
- (void)setLS_height:(CGFloat)LS_height
{
    CGRect frame = self.frame;
    frame.size.height = LS_height;
    self.frame = frame;
}

// origin
- (CGPoint)LS_origin
{
    return self.frame.origin;
}
- (void)setLS_origin:(CGPoint)LS_origin
{
    CGRect frame = self.frame;
    frame.origin = LS_origin;
    self.frame = frame;
}

// size
- (CGSize)LS_size
{
    return self.frame.size;
}
- (void)setLS_size:(CGSize)LS_size
{
    CGRect frame = self.frame;
    frame.size = LS_size;
    self.frame = frame;
}

// centerX
- (CGFloat)LS_centerX
{
    return self.center.x;
}
- (void)setLS_centerX:(CGFloat)LS_centerX
{
    CGPoint center = self.center;
    center.x = LS_centerX;
    self.center = center;
}

// centerY
- (CGFloat)LS_centerY
{
    return self.center.y;
}
- (void)setLS_centerY:(CGFloat)LS_centerY
{
    CGPoint center = self.center;
    center.y = LS_centerY;
    self.center = center;
}

// maxX
- (CGFloat)LS_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setLS_maxX:(CGFloat)LS_maxX
{
    CGRect frame = self.frame;
    frame.origin.x = LS_maxX - self.frame.size.width;
    self.frame = frame;
}

// maxY
- (CGFloat)LS_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setLS_maxY:(CGFloat)LS_maxY
{
    CGRect frame = self.frame;
    frame.origin.y = LS_maxY - self.frame.size.height;
    self.frame = frame;
}

@end







