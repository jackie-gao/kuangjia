//
//  LSImageBrowserViewController.m
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSImageBrowserViewController.h"
#import "LSImageItem.h"
#import "LSImageCell.h"
#import "LSImageBrowserHeader.h"

@interface LSImageBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<LSImageItem*> *imageItems;
@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong) UIWindow *window;

@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic,strong) LSImageScrollView *selectImageScrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UILabel *pageLabel;
@property(nonatomic,strong) UIView *bottomToolView;

@property(nonatomic,assign) CGPoint startLocation;

@end

@implementation LSImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupPageControlStyle];
    [self addGestureRecognizer];
}



#pragma mark - <初始化>
+ (instancetype)browserWithImageItems:(NSArray<LSImageItem *> *)imageItems selectedIndex:(NSInteger)selectIndex
{
    LSImageBrowserViewController *browserVC = [[LSImageBrowserViewController alloc]initWithImageItems:imageItems selectedIndex:selectIndex];
    return browserVC;
}

- (instancetype)initWithImageItems:(NSArray<LSImageItem *> *)imageItems selectedIndex:(NSInteger)selectedIndex
{
    if (self = [super init]) {
        self.imageItems = imageItems;
        self.selectedIndex = selectedIndex;
        self.pageStyle = imageItems.count > 9 ? LSImageBrowserpageStyleText : LSImageBrowserpageStyleDot;
    }
    return self;
}



#pragma mark - <基本设置>
- (void)setupBasic
{
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[LSImageCell class] forCellWithReuseIdentifier:NSStringFromClass([LSImageCell class])];
    
    [self.view addSubview:self.bottomToolView];
}



#pragma mark - <API>
// 显示图片浏览器
- (void)showImageBrowser
{
    UIWindow *window = [[UIWindow alloc]initWithFrame:kRect(0, 0, kImageBrowserWidth, kImageBrowserHeight)];
    self.window = window;
    window.windowLevel = UIWindowLevelAlert;
    window.rootViewController = self;
    window.backgroundColor = kBlackColor;
    [window makeKeyAndVisible];
    self.view.hidden = YES;
    window.hidden = NO;
    self.collectionView.alpha = 0;
    
    LSImageItem *imageItem = self.imageItems[self.selectedIndex];
    if (self.selectedIndex > self.imageItems.count) {
        return;
    }
    
    if (imageItem.sourceView != nil) {
        [self showImageBrowserFormSourceView:imageItem];
    }
    else {
        [self showImageBrowserFromWindow:imageItem];
    }
}



#pragma mark - <action>
#pragma mark <event>
// 单击手势
- (void)singleGestureAction
{
    [self hideImageBrowser];
}

// 双击手势
- (void)doubleGestureAction:(UITapGestureRecognizer *)tapGes
{
    if (self.selectImageScrollView.zoomScale > 1) {
        [self.selectImageScrollView setZoomScale:1 animated:YES];
    }
    else {
        CGPoint location = [tapGes locationInView:self.view];
        CGFloat maxZoomScale = self.selectImageScrollView.maximumZoomScale;
        CGFloat width = self.view.bounds.size.width / maxZoomScale;
        CGFloat height = self.view.bounds.size.height / maxZoomScale;
        // 以点击的目标的中心点的一个矩形
        [self.selectImageScrollView zoomToRect:kRect(location.x - width / 2, location.y - height / 2, width, height) animated:YES];
    }
}

// 移动手势
- (void)panGestureAction:(UIPanGestureRecognizer *)panGes
{
    if (self.selectImageScrollView.zoomScale > 1.1) {
        return;
    }
    // 平移，缩放效果
    [self scaleWithPanRecognizer:panGes];
}



#pragma mark - <delegate>
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSImageCell *cell = [LSImageCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.imageItem = self.imageItems[indexPath.item];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width - 20, kImageBrowserHeight);
}


#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width + 0.5;
    self.selectedIndex = page;
    LSImageScrollView *imageScrollView = [LSImageCell collectionView:self.collectionView imageScrollViewForPage:page];
    self.selectImageScrollView = imageScrollView;
    
    [self setupCurrentDidScrollForCurrentPage:page];
}



#pragma mark - <method>
/// 设置pageControl的样式
- (void)setupPageControlStyle
{
    // 当图片大于9张的的时候，默认呈现text样式
    if (self.pageStyle == LSImageBrowserpageStyleDot) {
        if (self.imageItems.count > 9) {
            [self.bottomToolView addSubview:self.pageLabel];
        } else {
            [self.bottomToolView addSubview:self.pageControl];
            self.pageControl.numberOfPages = self.imageItems.count;
            self.pageControl.currentPage = self.selectedIndex;
        }
    }
    else {
        [self.bottomToolView addSubview:self.pageLabel];
    }
}

/// 添加手势
- (void)addGestureRecognizer
{
    // 单击手势
    UITapGestureRecognizer *singleGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleGestureAction)];
    singleGes.numberOfTapsRequired = 1;
    
    // 双击手势
    UITapGestureRecognizer *doubleGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleGestureAction:)];
    doubleGes.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleGes];
    
    // 双击确定检测失败才会触发单击
    [singleGes requireGestureRecognizerToFail:doubleGes];
    [self.view addGestureRecognizer:singleGes];
    
    // 移动手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:panGes];
}

/// 单击手势隐藏视图
- (void)hideImageBrowser
{
    LSImageItem *imageItem = [self.imageItems objectAtIndex:self.selectedIndex];
    [self handleRecognizerBegin];
    
    if (imageItem.sourceView != nil) {
        UIImageView *tempImageView = self.selectImageScrollView.imageView;
        imageItem.sourceView.alpha = 0;
        CGRect currentRect = [imageItem.sourceView.superview convertRect:imageItem.sourceView.frame toView:self.window];
        [UIView animateWithDuration:0.5 animations:^{
            tempImageView.frame = currentRect;
            self.collectionView.backgroundColor = kClearColor;
            self.view.backgroundColor = kClearColor;
            self.window.backgroundColor = kClearColor;
            if (!CGRectIntersectsRect(currentRect, kImageBrowserScreenBounds)) {
                // 超出范围，不缩放，直接变形消失
                tempImageView.hidden = YES;
            }
        } completion:^(BOOL finished) {
            tempImageView.hidden = YES;
            [self endImageBrowser];
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self endImageBrowser];
        }];
    }
}

/// 手势开始
- (void)handleRecognizerBegin
{
    // 取消当前加载图片的请求
    [self.selectImageScrollView cancelCurrentImageLoading];
    
    LSImageItem *imageItem = [self.imageItems objectAtIndex:self.selectedIndex];
    imageItem.sourceView.alpha = 0;
    [self.collectionView layoutIfNeeded];
    
    LSImageCell *cell = (LSImageCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [cell progressLayerIsHidden:YES];
}

/// 关闭图片浏览器
- (void)endImageBrowser
{
    [self.collectionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    LSImageItem *imageItem = [self.imageItems objectAtIndex:self.selectedIndex];
    self.window.rootViewController = nil;
    self.window.hidden = YES;
    self.collectionView.hidden = YES;
    self.view.hidden = YES;
    [self.collectionView removeFromSuperview];
    imageItem.sourceView.alpha = 1;
}

/// 平移，缩放效果
- (void)scaleWithPanRecognizer:(UIPanGestureRecognizer *)gesPan
{
    CGPoint point = [gesPan translationInView:self.view];
    CGPoint location = [gesPan locationInView:self.view];
    CGPoint velocity = [gesPan velocityInView:self.view];
    switch (gesPan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startLocation = location;
            [self handleRecognizerBegin];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            double percent = 1 - fabs(point.y) / self.view.bounds.size.height;
            percent = MAX(percent, 0);
            double s = MAX(percent, 0.5);
            CGAffineTransform translation = CGAffineTransformMakeTranslation(point.x / s, point.y / s);
            CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
            self.selectImageScrollView.imageView.transform = CGAffineTransformConcat(translation, scale);
            self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:percent];
            self.collectionView.alpha = percent;
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (fabs(point.y) > 100 || fabs(velocity.y) > 500) {
                [self hideImageBrowser];
            } else {
                [self cancelGestureRecognizerAnimation];
            }
        }
            break;
            
        default:
            break;
    }
}

/// 取消手势动画，恢复图片的原始状态
- (void)cancelGestureRecognizerAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        self.selectImageScrollView.imageView.transform = CGAffineTransformIdentity;
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.alpha = 1;
        self.view.backgroundColor = UIColor.blackColor;
        self.view.alpha = 1;
        [self.collectionView reloadData];
    } completion:^(BOOL finished) {
        LSImageItem *imageItem = [self.imageItems objectAtIndex:self.selectedIndex];
        imageItem.sourceView.alpha = 1;
    }];
}

/// 设置当前image的Page
- (void)setupCurrentDidScrollForCurrentPage:(NSInteger)currentPage
{
    if (self.pageStyle == LSImageBrowserpageStyleDot) {
        self.pageControl.currentPage = currentPage;
    }
    else {
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%lu", (long)currentPage + 1, (unsigned long)self.imageItems.count];
    }
}

/// 显示图片浏览器到sourceView上
- (void)showImageBrowserFormSourceView:(LSImageItem *)imageItem
{
    if (imageItem.thumbImage == nil) return;
    
    CGRect currentRect = [imageItem.sourceView convertRect:imageItem.sourceView.bounds toView:self.window];
    UIImageView *tempImageView = [[UIImageView alloc]init];
    tempImageView.image = imageItem.thumbImage;
    tempImageView.frame = currentRect;
    [self.window addSubview:tempImageView];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat height = kImageBrowserWidth * (tempImageView.image.size.height / tempImageView.image.size.width);
        tempImageView.bounds = kRect(0, 0, kImageBrowserWidth, height);
        tempImageView.center = CGPointMake(kImageBrowserWidth / 2, kImageBrowserHeight / 2);
        self.collectionView.alpha = 1;
    } completion:^(BOOL finished) {
        tempImageView.hidden = YES;
        [tempImageView removeFromSuperview];
        self.window.backgroundColor = UIColor.clearColor;
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.view.backgroundColor = UIColor.blackColor;
        self.view.hidden = NO;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self scrollViewDidScroll:self.collectionView];
    }];
}

/// 显示图片浏览器到window上
- (void)showImageBrowserFromWindow:(LSImageItem *)imageItem
{
    [UIView animateWithDuration:0.2 animations:^{
        self.collectionView.alpha = 1;
    } completion:^(BOOL finished) {
        self.view.hidden = NO;
        self.view.backgroundColor = UIColor.blackColor;
        self.window.backgroundColor = UIColor.clearColor;
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self scrollViewDidScroll:self.collectionView];
    }];
}



#pragma mark - <lazy>
- (NSArray<LSImageItem *> *)imageItems
{
    if (!_imageItems) {
        _imageItems = [NSArray array];
    }
    return _imageItems;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = kImageBrowserCollectionMargin;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:kRect(0, 0, kImageBrowserWidth + kImageBrowserCollectionMargin, kImageBrowserHeight) collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, kImageBrowserCollectionMargin);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.clearColor;
    }
    return _collectionView;
}

- (UIView *)bottomToolView
{
    if (!_bottomToolView) {
        CGFloat height = 40;
        if (IS_LiuHai_Screen) {
            height += 20;
        }
        _bottomToolView = [[UIView alloc]initWithFrame:kRect(0, kImageBrowserHeight- height, kImageBrowserWidth, height)];
        _bottomToolView.backgroundColor = UIColor.clearColor;
    }
    return _bottomToolView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:kRect(0, 20, self.bottomToolView.bounds.size.width, 20)];
    }
    return _pageControl;
}

- (UILabel *)pageLabel
{
    if (!_pageLabel) {
        CGFloat height = 20;
        CGFloat y = (self.bottomToolView.bounds.size.height - 20) / 2;
        _pageLabel = [[UILabel alloc]initWithFrame:kRect(0, y, self.bottomToolView.bounds.size.width, height)];
        _pageLabel.font = [UIFont systemFontOfSize:16];
        _pageLabel.textColor = UIColor.whiteColor;
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.backgroundColor = UIColor.clearColor;
    }
    return _pageLabel;
}

@end
