//
//  LSGuideViewController.m
//
//  Created by larson on 2017/10/26.
//  Copyright © 2017年 larson. All rights reserved.
//

// UICollectionView内部已经遵守了代理协议

#import "LSGuideViewController.h"
#import "LSGuideCell.h"
#import "ZXKJTabBarController.h"

/// 引导页的张数
#define LSPages 3

@interface LSGuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak) UICollectionView *collectionView;
/** 跳过按钮*/
@property(nonatomic,weak) UIButton *jumpButton;
@property(nonatomic,weak) UIPageControl *pageControl;

@end

@implementation LSGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    [self.collectionView registerClass:[LSGuideCell class] forCellWithReuseIdentifier:NSStringFromClass([LSGuideCell class])];
    
    [self.jumpButton addTarget:self action:@selector(jumpButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.pageControl.numberOfPages = LSPages;
}



#pragma mark - <设置collectionView>
- (void)setUpCollectionView
{
    self.collectionView.backgroundColor = [UIColor redColor];
    [self.collectionView registerClass:[LSGuideCell class] forCellWithReuseIdentifier:NSStringFromClass([LSGuideCell class])];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
}



#pragma mark - <action>
- (void)jumpButtonAction
{
    // 保存最新版本
    kUserDefaultsSetValueAndKey(kAppReleaseVersion, ZCKJGuidePageVersionKey);
    
    kRootViewController = [[ZXKJTabBarController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = @"fade";
    [kKeyWindow.layer addAnimation:animation forKey:nil];
}



#pragma mark - <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return LSPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LSGuideCell class]) forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"guidance_%ld", (long)indexPath.item + 1];
    cell.image = [UIImage imageNamed:imageName];
    // 最后一行
    [cell setUpIndexPath:indexPath count:LSPages];
    
    return cell;
}


#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewWidth = scrollView.LS_width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = (offsetX + scrollViewWidth / 2) / scrollViewWidth;
    self.pageControl.currentPage = page;
}



#pragma mark - <lazy>
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = kScreenBounds.size;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.bounces = NO;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = kRGBColor(238, 246, 255);
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _collectionView;
}

- (UIButton *)jumpButton
{
    if (!_jumpButton) {
        CGFloat width = 50;
        CGFloat height = 20;
        CGFloat x = kScreenWidth - 14 - width;
        CGFloat y = kHeightStatusBar + 20;
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(x, y, width, height);
        [button setTitle:@"跳过" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:kRGBColor(153, 153, 153) forState:UIControlStateNormal];
        button.layer.cornerRadius = height / 2;
        button.layer.borderColor = kRGBColor(221, 221, 221).CGColor;
        button.layer.borderWidth = 1;
        [self.view addSubview:button];
        self.jumpButton = button;
    }
    return _jumpButton;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGFloat width = 150;
        CGFloat height = 20;
        CGFloat x = (kScreenWidth - width) / 2;
        CGFloat y = kScreenHeight - kHeightBottomSafe - 8 - height;
        if (IS_LiuHai_Screen) {
            y += 20;
        }
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.frame = CGRectMake(x, y, width, height);
        pageControl.pageIndicatorTintColor = kRGBColorWithAlpha(153, 153, 153, 0.3);
        pageControl.currentPageIndicatorTintColor = kRGBColor(153, 153, 153);
        pageControl.userInteractionEnabled = NO;
        [self.view addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return _pageControl;
}

@end











