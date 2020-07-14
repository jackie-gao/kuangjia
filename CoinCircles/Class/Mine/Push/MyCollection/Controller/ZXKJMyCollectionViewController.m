//
//  ZXKJMyCollectionViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMyCollectionViewController.h"
#import "ZXKJMyCollectionCell.h"
#import "ZXKJNewsDetailsViewController.h"
#import "ZXKJNewsModel.h"

@interface ZXKJMyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) NSMutableArray *collcetDatas;
@property(nonatomic,assign) BOOL isLoad;

@end

@implementation ZXKJMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupRefresh];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"我的收藏";
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJMyCollectionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJMyCollectionCell class])];
    self.tableView.rowHeight = 100;
    
    self.tableView.emptyView = [ZXKJEmptyView emptyActionViewWithImageString:@"no_data" titleString:nil detailString:@"暂无收藏"];
    self.tableView.emptyView.contentViewY = 60;
    
    self.isLoad = NO;
}



#pragma mark - <setupRefresh>
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark - <load data>
- (void)loadDatas
{
    kDispatch_after(0.5, ^{
        self.isLoad = YES;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self.tableView ls_endLoading];
    });
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isLoad == YES ? self.collcetDatas.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJMyCollectionCell class])];
    cell.separatorLineHidden = (indexPath.row == self.collcetDatas.count - 1) ? YES : NO;
    cell.model = self.collcetDatas[indexPath.row];

    return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    kWeakSelf(self);
    ZXKJNewsDetailsViewController *newDetailsVC = ZXKJNewsDetailsViewController.alloc.init;
    newDetailsVC.model = self.collcetDatas[indexPath.row];
    newDetailsVC.cancelCollectBlock = ^{
        [weak_self.collcetDatas removeAllObjects];
        weak_self.collcetDatas = [NSMutableArray arrayWithArray:[[LSDataBase sharedDataBase] getAllCollectData]];
        [weak_self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:newDetailsVC animated:YES];
    
}



#pragma mark - <lazy>
- (NSMutableArray *)collcetDatas
{
    if (!_collcetDatas) {
        if ([[LSDataBase sharedDataBase] getAllCollectData]) {
            _collcetDatas = [NSMutableArray arrayWithArray:[[LSDataBase sharedDataBase] getAllCollectData]];
        }
        else {
            _collcetDatas = [@[] mutableCopy];
        }
    }
    return _collcetDatas;
}

@end
