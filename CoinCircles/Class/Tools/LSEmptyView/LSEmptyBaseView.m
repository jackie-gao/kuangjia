//
//  LSEmptyBaseView.m
//  LSEmptyView
//
//  Created by larson on 2019/4/16.
//  Copyright © 2019年 qingYunHotelInfo. All rights reserved.
//

#import "LSEmptyBaseView.h"
#import "LSEmptyViewHeader.h"

@implementation LSEmptyBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}

- (void)prepare
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *view = self.superview;
    if (view && [view isKindOfClass:[UIView class]]) {
        self.LS_width = view.LS_width;
        self.LS_height = view.LS_height;
    }
    
    [self setupSubviews];
}

- (void)setupSubviews{}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 不是UIView，不做操作
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]]) return;
    
    if (newSuperview) {
        self.LS_width = newSuperview.LS_width;
        self.LS_height = newSuperview.LS_height;
    }
}



#pragma mark - <instantiation>
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString
                       buttonTitleString:(NSString *)buttonTitleString
                                  target:(id)target
                                  action:(SEL)action
{
    LSEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView createEmptyViewWithImage:image imageString:nil titleString:titleString detailString:detailString buttonTitleString:buttonTitleString target:target action:action buttonActionBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString
                       buttonTitleString:(NSString *)buttonTitleString
                       buttonActionBlock:(LSActionTapBlock)buttonActionBlock
{
    LSEmptyBaseView *emptyView = [[self alloc]init];
    [emptyView createEmptyViewWithImage:image imageString:nil titleString:titleString detailString:detailString buttonTitleString:buttonTitleString target:nil action:nil buttonActionBlock:buttonActionBlock];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString
                             buttonTitleString:(NSString *)buttonTitleString
                                        target:(id)target
                                        action:(SEL)action
{
    LSEmptyBaseView *emptyView = [[self alloc]init];
    [emptyView createEmptyViewWithImage:nil imageString:imageString titleString:titleString detailString:detailString buttonTitleString:buttonTitleString target:target action:action buttonActionBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString
                             buttonTitleString:(NSString *)buttonTitleString
                             buttonActionBlock:(LSActionTapBlock)buttonActionBlock
{
    LSEmptyBaseView *emptyView = [[self alloc] init];
    [emptyView createEmptyViewWithImage:nil imageString:imageString titleString:titleString detailString:detailString buttonTitleString:buttonTitleString target:nil action:nil buttonActionBlock:buttonActionBlock];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString
{
    LSEmptyBaseView *emptyView = [[self alloc]init];
    [emptyView createEmptyViewWithImage:image imageString:nil titleString:titleString detailString:detailString buttonTitleString:nil target:nil action:nil buttonActionBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString
{
    LSEmptyBaseView *emptyView = [[self alloc]init];
    [emptyView createEmptyViewWithImage:nil imageString:imageString titleString:titleString detailString:detailString buttonTitleString:nil target:nil action:nil buttonActionBlock:nil];
    
    return emptyView;
}

+ (instancetype)emptyViewWithCustomView:(UIView *)customView
{
    LSEmptyBaseView *emptyView = [[self alloc]init];
    [emptyView createEmptyViewWithCustomView:customView];
    
    return emptyView;
}



#pragma mark - <setter>
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self setNeedsLayout];
}

- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    
    [self setNeedsLayout];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    [self setNeedsLayout];
}

- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    
    [self setNeedsLayout];
}

- (void)setButtonTitleString:(NSString *)buttonTitleString
{
    _buttonTitleString = buttonTitleString;
    
    [self setNeedsLayout];
}



#pragma mark - <action>
#pragma mark <gestureAction>
- (void)contentViewTapGestureHandle
{
    !self.tapContentViewBlock ? : self.tapContentViewBlock();
}


#pragma mark - <method>
/// 创建EmptyView
- (void)createEmptyViewWithImage:(UIImage *)image imageString:(NSString *)imageString titleString:(NSString *)titleString detailString:(NSString *)detailString buttonTitleString:(NSString *)buttonTitleString target:(id)target action:(SEL)action buttonActionBlock:(LSActionTapBlock )buttonActionBlock
{
    _image = image;
    _imageString = imageString;
    _titleString = titleString;
    _detailString = detailString;
    _buttonTitleString = buttonTitleString;
    _actionButtonTarget = target;
    
    // 内容物背景图
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentViewTapGestureHandle)];
        [_contentView addGestureRecognizer:tapGesture];
    }
}

// 创建自定义的EmptyView
- (void)createEmptyViewWithCustomView:(UIView *)customView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_contentView];
    }
    
    if (_customView) {
        [_contentView addSubview:customView];
    }
    
    _customView = customView;
}

@end
