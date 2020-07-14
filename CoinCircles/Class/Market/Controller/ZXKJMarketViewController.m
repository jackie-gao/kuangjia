//
//  ZXKJMarketViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/5.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMarketViewController.h"
#import "ZXKJMarketSectionHeaderView.h"
#import "ZXKJMarketCell.h"
#import "ZXKJMarketSectionModel.h"
#import "ZXKJMarketModel.h"


@interface ZXKJMarketViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) NSMutableArray *datas;

@end

@implementation ZXKJMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self loadData];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"上榜";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJMarketCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJMarketCell class])];
}



#pragma mark - <loadData>
- (void)loadData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"market.plist" ofType:nil];
    [LSMaskTool showLoad];
    kDispatch_after(0.5, ^{
        [LSMaskTool dismiss];
        self.datas = [ZXKJMarketSectionModel mj_objectArrayWithFile:filePath];
        [self.tableView reloadData];
    });
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZXKJMarketSectionModel *model = self.datas[section];
    
    return model.details.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJMarketCell class])];
    ZXKJMarketSectionModel *sectionModel = self.datas[indexPath.section];
    ZXKJMarketModel *model = sectionModel.details[indexPath.row];
    cell.model = model;
    cell.separatorLineHidden = (indexPath.row == sectionModel.details.count - 1) ? YES : NO;

    return cell;
}


#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZXKJMarketSectionHeaderView *sectionView = [ZXKJMarketSectionHeaderView headerViewWithTableView:tableView];
    ZXKJMarketSectionModel *sectionModel = self.datas[section];
    sectionView.sectionModel = sectionModel;
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

@end
