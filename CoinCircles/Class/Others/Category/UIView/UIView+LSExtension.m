//
//  UIView+LSExtension.m
//
//  Created by larson on 2016/1/1.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "UIView+LSExtension.h"

@implementation UIView (LSExtension)


#pragma mark - <快捷设置frame>
#pragma mark <x值>
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

#pragma mark <y值>
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


#pragma mark <宽>
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


#pragma mark <高>
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


#pragma mark <size>
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


#pragma mark <centerX>
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


#pragma mark <centerY>
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


#pragma mark <maxX>
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


#pragma mark <maxY>
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



#pragma mark - <xib的一些设置>
// 快速创建xib控件
+ (instancetype)viewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// xib嵌套xib时候，同来给嵌套的view绑定xib
- (void)setupSelfNameXibOnSelf
{
    // 获取xib的容器控制器
    UIView *containerView = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    containerView.frame = self.bounds;
    [self addSubview:containerView];
}



#pragma mark - <获得当前视图的容器控制器>
- (UIViewController *)getCurrentViewForContainerController
{
    for (UIView *nextView = [self superview]; nextView; nextView = nextView.superview) {
        UIResponder *nextRespod = [nextView nextResponder];
        if ([nextRespod isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextRespod;
        }
    }
    return nil;
}




#pragma mark - <判断一个控件是否真正显示在主窗口上>
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIWindow *keyWindow = UIApplication.sharedApplication.windows.firstObject;
    
    // 以主窗口左上角坐标为原点，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowsBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowsBounds);
    
    return !self.hidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}



#pragma mark - <从父控件中获取需要获取的子控件(使用父控件来调用)>
- (instancetype)getDesignationView:(Class)designationClass
{
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:designationClass]) {
            return childView;
        }
    }
    return nil;
}



#pragma mark - <绘制一条虚线>
// lineView：需要绘制虚线的view
// lineLength：虚线的宽度
// lineSpacing：虚线的间距
// lineColor：虚线的颜色
// lineDirection：虚线的方向(YES：水平方向，NO：垂直方向)
- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    if (isHorizonal) { // 水平方向
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end







