//
//  ZXKJAttentionViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

// ----- 我的 -> 关注 ----- //

#import "ZXKJAttentionViewController.h"
#import "LSCollectionViewFlowLayout.h"
#import "ZXKJCelebrityModel.h"
#import "ZXKJAttentionCell.h"
#import "ZXKJCelebrityDetailsViewController.h"

@interface ZXKJAttentionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LSCollectionViewDelegateFlowLayout>
@property(nonatomic,strong) LSCollectionViewFlowLayout *flowLayout;
@property(nonatomic,weak) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,assign) BOOL isLoadDatas;

@end

@implementation ZXKJAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self loadDatas];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"关注";
    self.view.backgroundColor = kWhiteColor;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJAttentionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ZXKJAttentionCell class])];
    
    self.collectionView.emptyView = [ZXKJEmptyView emptyActionViewWithImageString:@"no_data" titleString:nil detailString:@"暂无收藏"];
    self.collectionView.emptyView.contentViewY = 60;
    
    self.isLoadDatas = NO;
}



#pragma mark - <setupRefresh>
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
}



#pragma mark - <loadDatas>
- (void)loadDatas
{
    [LSMaskTool showLoad];
    kWeakSelf(self);
    kDispatch_after(0.5, ^{
        [LSMaskTool dismiss];
        self.isLoadDatas = YES;
        [weak_self.collectionView reloadData];
        [weak_self.collectionView ls_endLoading];
    });
}



#pragma mark - <delegate>
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.isLoadDatas ? self.datas.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJAttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZXKJAttentionCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(self);
    ZXKJCelebrityModel *model = self.datas[indexPath.item];
    ZXKJCelebrityDetailsViewController *celebrityDetailsVC = [[ZXKJCelebrityDetailsViewController alloc]init];
    celebrityDetailsVC.model = model;
    celebrityDetailsVC.cancelAttentionBlock = ^{
        [weak_self loadDatas];
    };
    [self.navigationController pushViewController:celebrityDetailsVC animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJAttentionCell *cell = (ZXKJAttentionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = kControllerBgColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJAttentionCell *cell = (ZXKJAttentionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = kWhiteColor;
}


#pragma mark <LSCollectionViewDelegateFlowLayout>
// 每个分组的背景色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    return [@[kWhiteColor] objectAtIndex:section];
}



#pragma mark - <lazy>
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        collectionView.LS_y = kHeightNavigationBar;
        collectionView.LS_height = kScreenHeight - kHeightNavigationBar;
        collectionView.backgroundColor = kClearColor;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _collectionView;
}

- (LSCollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        CGFloat screenMargin = 15;
        CGFloat bottomMargin = 20;
        _flowLayout = [[LSCollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = screenMargin;
        _flowLayout.minimumInteritemSpacing = screenMargin;
        CGFloat itemWidth = (self.view.LS_width - screenMargin * 2 - screenMargin) / 2;
        CGFloat itemHeight = kRelativityHeight(220);
        _flowLayout.itemSize = kSize(itemWidth, itemHeight);
        _flowLayout.sectionInset = kEdgeInsets(screenMargin, screenMargin, bottomMargin, screenMargin);
    }
    return _flowLayout;
}

- (NSMutableArray *)datas
{
    [_datas removeAllObjects];
    if ([[LSDataBase sharedDataBase] getAllCelebrityData]) {
        _datas = [NSMutableArray arrayWithArray:[[LSDataBase sharedDataBase] getAllCelebrityData]];
    }
    else {
        _datas = [@[] mutableCopy];
    }
    return _datas;
}

@end
