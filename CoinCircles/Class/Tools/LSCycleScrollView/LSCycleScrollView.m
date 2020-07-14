//
//  LSCycleScrollView.m
//  collectionView轮播图
//
//  Created by larson on 2019/1/26.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSCycleScrollView.h"
#import "LSCollectionViewCell.h"
#import "LSPageControl.h"
#import <UIImageView+WebCache.h>

#define kCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)

@interface LSCycleScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** 显示图片的collectionView*/
@property(nonatomic,weak) UICollectionView *mainView;
/** 布局对象*/
@property(nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
/** 图片数组*/
@property(nonatomic,strong) NSArray *imagePathsGroup;
/** 定时器*/
@property(nonatomic,weak) NSTimer *timer;
/** 轮播图的个数*/
@property(nonatomic,assign) NSInteger totalItemsCount;
@property(nonatomic,weak) UIControl *pageControl;

/** 当imageURLs为空时的背景图*/
@property(nonatomic,strong) UIImageView *backgroundImageView;

@end

@implementation LSCycleScrollView

#pragma mark - <初始化>
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
        [self setupMainView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupBasic];
        [self setupMainView];
    }
    return self;
}


#pragma mark <类方法创建>
// 使用网络图片初始化
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    LSCycleScrollView *cycleScrollView = [[self alloc]initWithFrame:frame];
    cycleScrollView.imageURLStringGroup = [NSMutableArray arrayWithArray:imageURLStringsGroup];
    
    return cycleScrollView;
}

// 本地图片轮播初始化方式
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup
{
    LSCycleScrollView *cycleScrollView = [[self alloc]initWithFrame:frame];
    cycleScrollView.localizaationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    
    return cycleScrollView;
}
// 本地图片轮播初始化方式2(infiniteLoop：是否无限循环)
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup
{
    LSCycleScrollView *cycleScrollView = [[self alloc]initWithFrame:frame];
    cycleScrollView.infiniteLoop = infiniteLoop;
    cycleScrollView.localizaationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    
    return cycleScrollView;
}



#pragma mark - <初始化方法>
- (void)setupBasic
{
    // 默认值
    self.pageControlAliment = LSCycleScrollViewPageControlAlimentCenter;
    self.autoScrollTimeInterval = 2.5;
    self.titleLabelTextColor = UIColor.whiteColor;
    self.titleLabelTextFont = [UIFont systemFontOfSize:14];
    self.titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.titleLabelHeight = 30;
    self.titleLabelTextAligment = NSTextAlignmentLeft;
    self.autoScroll = YES;
    self.infiniteLoop = YES;
    self.showPageControl = YES;
    self.pageControlDotSize = kCycleScrollViewInitialPageControlDotSize;
    self.pageControlBottomOffset = 0;
    self.pageControlRightOffset = 0;
    self.pageControlStyle = LSCycleScrollViewPageControlStyleClassic;
    self.hiddenForSinglePage = YES;
    self.currentPageDotColor = UIColor.whiteColor;
    self.pageDotColor = UIColor.lightGrayColor;
    self.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.backgroundColor = UIColor.clearColor;
}



#pragma mark - <初始化控件>
#pragma mark <轮播控件>
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = UIColor.clearColor;
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[LSCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LSCollectionViewCell class])];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    self.mainView = mainView;
}

#pragma mark <pageControl>
- (void)setupPageControl
{
    // 重新加载数据时调用
    if (self.pageControl) [self.pageControl removeFromSuperview];
    
    if (self.imagePathsGroup.count == 0 || self.onlyDisplayText) return;
    
    if (self.imagePathsGroup.count == 1 && self.hiddenForSinglePage) return;
    
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    
    switch (self.pageControlStyle) {
        case LSCycleScrollViewPageControlStyleAnimation:
        {
            LSPageControl *pageControl = [[LSPageControl alloc]init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.dotColor = self.currentPageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            self.pageControl = pageControl;
        }
            break;
            
        case LSCycleScrollViewPageControlStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc]init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.pageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            self.pageControl = pageControl;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pageControlDot图片
    if (self.currentPageDotImage) {
        self.currentPageDotImage = self.currentPageDotImage;
    }
    if (self.pageDotImage) {
        self.pageDotImage = self.pageDotImage;
    }
}

#pragma mark  <定时器>
/// 开始定时器
- (void)setupTimer
{
    // 创建定时器前先停止定时器。不然会出现僵尸定时器，导致轮播频率错误
    [self invalidateTimer];
    
    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/// 停止计时器
- (void)invalidateTimer
{
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark - <setter>
// 占位图片(用于网络未加载到图片时)
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [[UIImageView alloc]init];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self insertSubview:bgImageView belowSubview:self.mainView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}

// 是否显示分页控件
- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    self.pageControl.hidden = !showPageControl;
}

// pageController原点的size
- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        pageControl.dotSize = pageControlDotSize;
    }
}

// 当前的分页圆点颜色
- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        pageControl.dotColor = currentPageDotColor;
    }else {
        UIPageControl *pageControl = (UIPageControl *)self.pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }
}
// 其他分页控件圆点的颜色
- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    
    if ([self.pageDotColor isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)self.pageControl;
        pageControl.pageIndicatorTintColor = pageDotColor;
    }
}

// 当前分页控件小园标的图片
- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    
    if (self.pageControlStyle != LSCycleScrollViewPageControlStyleAnimation) {
        self.pageControlStyle = LSCycleScrollViewPageControlStyleAnimation;
    }
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}
// 分页控件其他园标的图片
- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    
    if (self.pageControlStyle != LSCycleScrollViewPageControlStyleAnimation) {
        self.pageControlStyle = LSCycleScrollViewPageControlStyleAnimation;
    }
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}

/// 自定义分页控件小圆标的颜色
- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        if (isCurrentPageDot) {
            pageControl.currentDotImage = image;
        } else {
            pageControl.dotImage = image;
        }
    }
}

// 是否无线循环
- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.imagePathsGroup.count) {
        self.imagePathsGroup = self.imagePathsGroup;
    }
}

// 自动滚动
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    if (autoScroll) {
        [self setupTimer];
    }
}

// 图片滚动方向
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    self.flowLayout.scrollDirection = scrollDirection;
}

// 自动滚动间隔时间
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

// PageControl的样式
- (void)setPageControlStyle:(LSCycleScrollViewPageControlStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    
    [self setupPageControl];
}

// 图片数组
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTimer];
    
    _imagePathsGroup = imagePathsGroup;
    self.totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
    
    if (imagePathsGroup.count > 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    [self setupPageControl];
    [self.mainView reloadData];
}

// 网络图片
- (void)setImageURLStringGroup:(NSArray *)imageURLStringGroup
{
    _imageURLStringGroup = imageURLStringGroup;
    
    NSMutableArray *temp = [NSMutableArray array];
    [imageURLStringGroup enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString = nil;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
}

// 本地图片数组
- (void)setLocalizaationImageNamesGroup:(NSArray *)localizaationImageNamesGroup
{
    _localizaationImageNamesGroup = localizaationImageNamesGroup;
    
    self.imagePathsGroup = [localizaationImageNamesGroup copy];
}

// 每张图片对应的文字数组
- (void)setTitlesGroup:(NSArray *)titlesGroup
{
    _titlesGroup = titlesGroup;
    if (self.onlyDisplayText) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger i = 0; i < titlesGroup.count; i++) {
            [temp addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.imageURLStringGroup = [temp copy];
    }
}

// 禁止手势滚动
- (void)disableScrollGesture
{
    self.mainView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.mainView.gestureRecognizers) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.mainView removeGestureRecognizer:gesture];
        }
    }
}



#pragma mark - <event>
/// 开始滚动
- (void)automaticScroll
{
    if (self.totalItemsCount == 0) return;
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

/// 滚动到指定的下标
- (void)scrollToIndex:(NSInteger)targetIndex
{
    if (targetIndex >= self.totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = self.totalItemsCount * 0.5;
            [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}



#pragma mark - <Method>
/// 当前的下标
- (NSInteger)currentIndex
{
    CGSize size = self.mainView.bounds.size;
    if (size.width == 0 || size.height == 0) return 0;
    
    NSInteger index = 0;
    CGPoint offset = self.mainView.contentOffset;
    CGSize itemSize = self.flowLayout.itemSize;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (offset.x + itemSize.width / 2) / itemSize.width;
    }
    else
    {
        index = (offset.y + itemSize.height / 2) / itemSize.height;
    }
    
    return MAX(0, index);
}

/// 根据当前cell的下标设置pageControl的下标
- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return index % self.imagePathsGroup.count;
}



#pragma mark - <布局子控件>
- (void)layoutSubviews
{
//    self.delegate = self.delegate;
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.frame.size;
    self.mainView.frame = self.bounds;
    if (self.mainView.contentOffset.x == 0 && self.totalItemsCount) {
        NSInteger targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = self.totalItemsCount / 2;
        } else {
            targetIndex = 0;
        }
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:0];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
            pageControl.dotSize = self.pageControlDotSize;
        }
        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
    } else {
        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    
    CGFloat x = (self.bounds.size.width - size.width) / 2;
    if (self.pageControlAliment == LSCycleScrollViewPageControlAlimentRight) {
        x = self.mainView.bounds.size.width - size.width - 10;
    }
    CGFloat y = self.mainView.bounds.size.height - size.height - 5;
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        [pageControl sizeToFit];
    }
    
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    pageControlFrame.origin.y -= self.pageControlBottomOffset;
    pageControlFrame.origin.x -= self.pageControlRightOffset;
    self.pageControl.frame = pageControlFrame;
    self.pageControl.hidden = !self.showPageControl;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
}



#pragma mark - <delegate>
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LSCollectionViewCell class]) forIndexPath:indexPath];
    
    NSInteger itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    NSString *imagePath = self.imagePathsGroup[itemIndex];
    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                image = [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    }
    else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (self.titlesGroup.count && itemIndex < self.titlesGroup.count) {
        cell.title = self.titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextAligment = self.titleLabelTextAligment;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
        cell.onlyDisplayText = self.onlyDisplayText;
        cell.hasConfigured = YES;
    }
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击的cell的index
    !self.clickItemOperationBlock ? : self.clickItemOperationBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    
}


#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 解决清除timer时出现的问题
    if (!self.imagePathsGroup.count) return;
    
    NSInteger itemIndex = [self currentIndex];
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.pageControl isKindOfClass:[LSPageControl class]]) {
        LSPageControl *pageControl = (LSPageControl *)self.pageControl;
        pageControl.currentPage = indexOnPageControl;
    } else {
        UIPageControl *pageControl = (UIPageControl *)self.pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.mainView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 解决清除timer时偶尔会出现的问题
    if (!self.imagePathsGroup.count) return;
    NSInteger itemIndex = [self currentIndex];
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    !self.itemDidScrollOperationBlock ? : self.itemDidScrollOperationBlock(indexOnPageControl);
}



#pragma mark - <外界调用API>
// 手动控制滚动到哪一个index
- (void)makeScrollViewScrollToIndex:(NSInteger)index
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
    if (self.totalItemsCount == 0) return;
    
    [self scrollToIndex:self.totalItemsCount / 2 + index];
    
    if (self.autoScroll) [self setupTimer];
}

// 解决viewWillAppear时出现轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法
- (void)adjustWhenControllerViewWillAppear
{
    NSInteger targetIndex = [self currentIndex];
    if (targetIndex < self.totalItemsCount) {
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

// 清除缓存
+ (void)clearImageCache
{
//    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
}



#pragma mark - <systemMedth>
// 解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

// 解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc
{
    self.mainView.delegate = nil;
    self.mainView.dataSource = nil;
}



@end
