//
//  ZXKJCelebrityViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCelebrityViewController.h"
#import "LSCollectionViewFlowLayout.h"
#import "ZXKJCelebrityCell.h"
#import "ZXKJCelebrityModel.h"
#import "ZXKJCelebrityDetailsViewController.h"

@interface ZXKJCelebrityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LSCollectionViewDelegateFlowLayout>
@property(nonatomic,strong) LSCollectionViewFlowLayout *flowLayout;
@property(nonatomic,weak) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *datas;

@end

@implementation ZXKJCelebrityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupRefresh];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"名人榜";
    self.view.backgroundColor = kWhiteColor;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJCelebrityCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ZXKJCelebrityCell class])];
}



#pragma mark - <setupRefresh>
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
}



#pragma mark - <loadDatas>
// load new data
- (void)loadNewDatas
{
    [self.collectionView ls_startLoading];
    NSMutableDictionary *params = [@{} mutableCopy];
    params[@"page"] = @1;
    params[@"size"] = @20;
    [ZXKJCelebrityModel loadDataWithParams:params success:^(id result) {
        [self.collectionView.mj_header endRefreshing];
        if (![result isKindOfClass:NSDictionary.class]) {
            return;
        }
        
        [self.datas removeAllObjects];
        self.datas = [ZXKJCelebrityModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
        [self.collectionView reloadData];
        [self.collectionView ls_endLoading];

    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}



#pragma mark - <delegate>
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCelebrityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZXKJCelebrityCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCelebrityModel *model = self.datas[indexPath.item];
    ZXKJCelebrityDetailsViewController *celebrityDetailsVC = [[ZXKJCelebrityDetailsViewController alloc]init];
    celebrityDetailsVC.model = model;
    [self.navigationController pushViewController:celebrityDetailsVC animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCelebrityCell *cell = (ZXKJCelebrityCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = kControllerBgColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCelebrityCell *cell = (ZXKJCelebrityCell *)[collectionView cellForItemAtIndexPath:indexPath];
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

@end
