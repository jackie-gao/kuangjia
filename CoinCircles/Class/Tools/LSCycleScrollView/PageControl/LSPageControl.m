//
//  LSPageControl.m
//  collectionView轮播图
//
//  Created by larson on 2019/2/17.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSPageControl.h"
#import "LSAbstractDotView.h"
#import "LSAnimatedDotView.h"
#import "LSDotView.h"

// 设置初始化值
/// 默认页面数
static NSInteger const kDefaultNumberOfPages = 0;
/// 默认的当前页
static NSInteger const kDefaultCurrentPage = 0;
/// 单个页面是否隐藏设置
static BOOL const kDefaultHideSinglePage = NO;
/// 是否从中间调整大小
static BOOL const kDefaultShouldResizeFromCenter = YES;
/// 点间距
static NSInteger const kDefaultSpacingBetweenDots = 8;
/// 默认大小
static CGSize const kDefaultDotSize = {8, 8};


@interface LSPageControl ()
@property(nonatomic,strong) NSMutableArray *dots;

@end

@implementation LSPageControl

#pragma mark - <初始化>
- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}


#pragma mark <初始化设置>
- (void)setup
{
    self.dotViewClass =             [LSAnimatedDotView class];
    self.spacingBetweenDots =       kDefaultSpacingBetweenDots;
    self.numberOfPages =            kDefaultNumberOfPages;
    self.currentPage =              kDefaultCurrentPage;
    self.hidesForSinglePage =       kDefaultHideSinglePage;
    self.shouldResizeFromCenter =   kDefaultShouldResizeFromCenter;
}



#pragma mark - <touch>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self) {
        NSInteger index = [self.dots indexOfObject:touch.view];
        if ([self.delegate respondsToSelector:@selector(LSPageControl:didSelectPageAtIndex:)]) {
            [self.delegate LSPageControl:self didSelectPageAtIndex:index];
        }
    }
}



#pragma mark - <layout>
// 调整和移动接收者视图，使其只包含子视图
- (void)sizeToFit
{
    [self updateFrame:YES];
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.dotSize.width + self.spacingBetweenDots) * pageCount - self.spacingBetweenDots, self.dotSize.height);
}

// 如果帧发生变化，更新它们的位置
- (void)updateDots
{
    if (self.numberOfPages == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < self.numberOfPages; i++) {\
        UIView *dot = nil;
        if (i < self.dots.count) {
            dot = [self.dots objectAtIndex:i];
        }else {
            dot = [self generateDotView];
        }
        
        [self updateDotFrame:dot anIndex:i];
    }
    
    [self changeActivity:YES atIndex:self.currentPage];
    [self hidesForSinglePage];
}

- (void)updateFrame:(BOOL)overrideExistingFrame
{
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];
    
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame))
    {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    [self resetDotViews];
}

/// 更新点的位置，适应新的页面数量
- (void)resetDotViews
{
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    
    [self.dots removeAllObjects];
    [self updateDots];
}


/**
 *  更新特定索引处的特定点的帧
 *
 *  @param dot     点视图
 *  @param index   索引页指引
 */
- (void)updateDotFrame:(UIView *)dot anIndex:(NSInteger)index
{
    CGFloat x = (self.dotSize.width + self.spacingBetweenDots) * index + ((CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    
    dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
}


/**
 *  生成一个点视图并将其添加到集合中
 *
 *  @return 返回一个点
 */
- (UIView *)generateDotView
{
    UIView *dotView = nil;
    if (self.dotViewClass) {
        dotView = [[self.dotViewClass alloc]initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];
        if ([dotView isKindOfClass:[LSAnimatedDotView class]] && self.dotColor) {
            ((LSAnimatedDotView *)dotView).dotColor = self.dotColor;
        }
    }
    else
    {
        dotView = [[UIImageView alloc]initWithImage:self.dotImage];
        dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
    }
    
    if (dotView) {
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }
    
    dotView.userInteractionEnabled = YES;
    
    return dotView;
}


/**
 *  更改点视图的活动状态
 *
 *  @param active 应用的活动状态
 *  @param index  状态更新的点索引
 */
- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index
{
    if (self.dotViewClass) {
        LSAbstractDotView *abstractDotView = (LSAbstractDotView *)[self.dots objectAtIndex:index];
        if ([abstractDotView respondsToSelector:@selector(changeActivityState:)]) {
            [abstractDotView changeActivityState:active];
        }else {
            NSLog(@"自定义view : %@ 必须实现'changeActivityState'方法，否则子类%@是无效的", self.dotViewClass, [LSAbstractDotView class]);
        }
    }else if (self.dotImage && self.currentDotImage) {
        UIImageView *dotView = (UIImageView *)[self.dots objectAtIndex:index];
        dotView.image = (active) ? self.currentDotImage : self.dotImage;
    }
}



- (void)hideForSinglePage
{
    if (self.dots.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
    }
}



#pragma mark - <setter>
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    [self resetDotViews];
}

- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots
{
    _spacingBetweenDots = spacingBetweenDots;
    
    [self resetDotViews];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    
    [self changeActivity:NO atIndex:_currentPage];
    [self changeActivity:YES atIndex:_currentPage];
}

- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    
    [self resetDotViews];
    self.dotViewClass = nil;
}

- (void)setCurrentDotImage:(UIImage *)currentDotImage
{
    _currentDotImage = currentDotImage;
    [self resetDotViews];
    self.dotViewClass = nil;
}

- (void)setDotViewClass:(Class)dotViewClass
{
    _dotViewClass = dotViewClass;
    
    self.dotSize = CGSizeZero;
    [self resetDotViews];
}



#pragma mark - <getter>
- (NSMutableArray *)dots
{
    if (!_dots) {
        _dots = [NSMutableArray array];
    }
    return _dots;
}

- (CGSize)dotSize
{
    if (self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = self.dotImage.size;
    } else if (self.dotViewClass && CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        return _dotSize;
    }
    return _dotSize;
}


@end
