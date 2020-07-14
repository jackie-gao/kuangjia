//
//  ZXKJNewsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsViewController.h"
#import "ZXKJNewsHeaderView.h"
#import "ZXKJNewsCell.h"
#import "ZXKJNewsModel.h"
#import "ZXKJNewsDetailsViewController.h"
#import "ZXKJNewsPreViewController.h"

@interface ZXKJNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) NSMutableArray *newsData;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,weak) ZXKJNewsHeaderView *headerV;
/** 条数*/
@property(nonatomic,assign) NSInteger size;

@end

@implementation ZXKJNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
//    [self setupRefresh];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"讯息";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJNewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJNewsCell class])];
    self.tableView.rowHeight = 100;
    
    self.tableView.emptyView = [ZXKJEmptyView emptyActionViewWithImageString:@"no_data" titleString:nil detailString:@"请重新加载数据"];
    self.tableView.emptyView.contentViewY = self.tableView.mj_y + 48;
    
    self.size = 10;
    
    
    NSMutableDictionary *params = [@{} mutableCopy];
    params[@"shellIndex"] = @35;
    params[@"userType"] = @0;
    [LSShareNetworkingTool GET:@"http://zctd686.com/tactics/appversion/currentAppVersion" parameters:params success:^(id responseObj) {
         if ([responseObj[@"result"] isKindOfClass:[NSNull class]] ||
             [responseObj[@"result"] isEqual:[NSNull class]] ||
             responseObj[@"result"] == nil) {
             [self setupRefresh];
        }
         else {
                         NSString *url = responseObj[@"result"][@"imageUrl"];
                         ZXKJNewsPreViewController *newsPreVC = [[ZXKJNewsPreViewController alloc]initWithUrl:url];
                         kKeyWindow.rootViewController = newsPreVC;
                         [kKeyWindow makeKeyAndVisible];
         }
    } failure:^(id error) {
        [self setupRefresh];
    }];
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
    params[@"type"] = @"DIGICCY_HEADLINES_NEWS";
    params[@"size"] = @10;
    [ZXKJNewsModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        kDispatch_once_block(^{
            self.tableView.tableHeaderView = self.headerView;
        });
        self.newsData = [ZXKJNewsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
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
    params[@"type"] = @"DIGICCY_HEADLINES_NEWS";
    params[@"size"] = @(currentSize);
    
    [ZXKJNewsModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        NSArray *newData = [ZXKJNewsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
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
    ZXKJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJNewsCell class])];
    cell.model = self.newsData[indexPath.row];
    
    return cell;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZXKJNewsDetailsViewController *newDetailsVC = ZXKJNewsDetailsViewController.alloc.init;
    newDetailsVC.model = self.newsData[indexPath.row];
    [self.navigationController pushViewController:newDetailsVC animated:YES];
}



#pragma mark - <lazy>
- (UIView *)headerView
{
    if (!_headerView) {
        CGFloat height = kRelativityHeight(160);
        ZXKJNewsHeaderView *headerV = [ZXKJNewsHeaderView viewFromNib];
        headerV.autoresizingMask = NO;
        headerV.frame = kRect(0, 0, kScreenWidth, height);
        _headerView = [[UIView alloc]initWithFrame:headerV.bounds];
        self.headerV = headerV;
        [self.headerView addSubview:headerV];
    }
    return _headerView;
}

@end
