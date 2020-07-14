//
//  ZXKJHeadlinesViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJHeadlinesViewController.h"
#import "ZXKJHeadlinesCell.h"
#import "ZXKJHeadlinesModel.h"
#import "ZXKJHeadlinesDetailsViewController.h"

@interface ZXKJHeadlinesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) NSMutableArray *newsData;
/** 条数*/
@property(nonatomic,assign) NSInteger size;


@end

@implementation ZXKJHeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupRefresh];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"头条资讯";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJHeadlinesCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJHeadlinesCell class])];
    self.tableView.rowHeight = 100;
    
    self.tableView.emptyView = [ZXKJEmptyView emptyActionViewWithImageString:@"no_data" titleString:nil detailString:@"请重新加载数据"];
    self.tableView.emptyView.contentViewY = self.tableView.mj_y + 48;
    
    self.size = 10;
}




#pragma mark - <setupRefresh>
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    self.tableView.mj_footer.hidden = YES;
}



#pragma mark - <loadDatas>
// load new data
- (void)loadNewDatas
{
    [self.tableView ls_startLoading];
    NSMutableDictionary *params = [@{} mutableCopy];
    params[@"type"] = @"DIGICCY_INDUSTRY_NEWS";
    params[@"size"] = @10;
    [ZXKJHeadlinesModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }

        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        self.newsData = [ZXKJHeadlinesModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
        [self.tableView reloadData];
        [self.tableView ls_endLoading];
        self.size = 10;
        self.tableView.mj_footer.hidden = NO;

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

// load more data
- (void)loadMoreDatas
{
    NSInteger currentSize = self.size + 10;
    NSMutableDictionary *params = [@{} mutableCopy];
    params[@"type"] = @"DIGICCY_INDUSTRY_NEWS";
    params[@"size"] = @(currentSize);
    
    [ZXKJHeadlinesModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }

        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        NSArray *newData = [ZXKJHeadlinesModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
        [self.newsData addObjectsFromArray:newData];
        [self.tableView reloadData];
        [self.tableView ls_endLoading];
        self.size = currentSize;

        if (self.size >= 20) {
            self.tableView.mj_footer.hidden = YES;
        }

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJHeadlinesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJHeadlinesCell class])];
    cell.model = self.newsData[indexPath.row];

    return cell;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ZXKJHeadlinesDetailsViewController *headlinesDetailsVC = ZXKJHeadlinesDetailsViewController.alloc.init;
//    headlinesDetailsVC.content = model.content;
//    headlinesDetailsVC.kTitle = model.title;
    headlinesDetailsVC.model = self.newsData[indexPath.row];
    [self.navigationController pushViewController:headlinesDetailsVC animated:YES];
}

@end
