//
//  ZXKJFlashNewsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJFlashNewsViewController.h"
#import "ZXKJFlashNewsCell.h"
#import "ZXKJFlashNewsModel.h"

@interface ZXKJFlashNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) NSMutableArray *newsData;
/** 条数*/
@property(nonatomic,assign) NSInteger size;

@end

@implementation ZXKJFlashNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupRefresh];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"快讯";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJFlashNewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJFlashNewsCell class])];
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
    params[@"type"] = @"DIGICCY_FLASH_NEWS";
    params[@"size"] = @10;
    [ZXKJFlashNewsModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        self.newsData = [ZXKJFlashNewsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
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
    params[@"type"] = @"DIGICCY_FLASH_NEWS";
    params[@"size"] = @(currentSize);
    
    [ZXKJFlashNewsModel loadDataWithParams:params success:^(id result) {
        if (![result isKindOfClass:NSDictionary.class]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.newsData removeAllObjects];

        NSArray *newData = [ZXKJFlashNewsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"records"]];
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
    ZXKJFlashNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJFlashNewsCell class])];
    cell.model = self.newsData[indexPath.row];

    return cell;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJFlashNewsModel *model = self.newsData[indexPath.row];
    
    return model.cellHeight;
}



- (NSMutableArray *)newsData
{
    if (_newsData) {
        NSInteger i = 0;
        for (ZXKJFlashNewsModel *model in _newsData) {
            if (i == 0) {
                model.isHideTopLine = YES;
            } else {
                model.isHideTopLine = NO;
            }
            i++;
        }
    }
    return _newsData;
}

@end
