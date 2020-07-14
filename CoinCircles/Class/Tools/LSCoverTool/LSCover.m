//
//  LSCover.m
//  larson
//
//  Created by larson on 2016/10/16.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "LSCover.h"

@interface LSCover ()
/** 蒙版消失的block*/
@property(nonatomic,copy) void(^dissmissBlock)(void);

@end

@implementation LSCover

// 使用静态变量之后，必须在dealloc里面赋空。静态变量有值，如果不在外界销毁，该类会一直被引用着
static UIView *superView_ = nil;

#pragma mark - <展示蒙版>
// 展示到keyWindow上
+ (void)showWithDissmissBlock:(void (^)(void))dissmissBlock
{
    LSCover *cover = [[LSCover alloc]initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cover.dissmissBlock = dissmissBlock;
    [UIApplication.sharedApplication.windows.firstObject addSubview:cover];
}

// 展示到指定的view上
+ (instancetype)showInView:(UIView *)superView positioningView:(UIView *)positioningView dismissBlock:(void(^)(void))dissmissBlock
{
    LSCover *cover = [[LSCover alloc]initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cover.dissmissBlock = dissmissBlock;
    [superView insertSubview:cover belowSubview:positioningView];

    superView_ = superView;
    
    return cover;
}



#pragma mark - <隐藏蒙版>
+ (void)dissmiss
{
    if (superView_ == nil) { // 添加到keyWindow上
        for (UIView *childView in kKeyWindow.subviews) {
            if ([childView isKindOfClass:self]) {
                [childView removeFromSuperview];
            }
        }
    }
    else
    { // 添加到指定的页面上
        for (UIView *childView in superView_.subviews) {
            if ([childView isKindOfClass:self]) {
                [childView removeFromSuperview];
            }
        }
        superView_ = nil;
    }
}

- (void)dissmiss
{
    for (UIView *childView in self.superview.subviews) {
        if ([childView isKindOfClass:[self class]]) {
            [childView removeFromSuperview];
        }
    }
    superView_ = nil;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    !self.dissmissBlock ? : self.dissmissBlock();
}



#pragma mark - <dealloc>
- (void)dealloc
{
    superView_ = nil;
}

@end
