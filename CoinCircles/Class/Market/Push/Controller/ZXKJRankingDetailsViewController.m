//
//  ZXKJRankingDetailsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRankingDetailsViewController.h"
#import "ZXKJRankingDetailsSectionHeaderView.h"
#import "ZXKJRankingDetailsCell.h"
#import "ZXKJRankingDetailsSectionModel.h"
#import "ZXKJRankingDetailsModel.h"

@interface ZXKJRankingDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJRankingDetailsSectionHeaderView *sectionHeaderView;

@end

@implementation ZXKJRankingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LSMaskTool showLoad];
    kDispatch_after(0.5, ^{
        [LSMaskTool dismiss];
        [self setupBasic];
    });
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = self.kTitle;
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJRankingDetailsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJRankingDetailsCell class])];
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZXKJRankingDetailsSectionModel *sectionModel = self.datas[section];
    
    return sectionModel.details.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJRankingDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJRankingDetailsCell class])];
    ZXKJRankingDetailsSectionModel *sectionModel = self.datas[indexPath.section];
    ZXKJRankingDetailsModel *model = sectionModel.details[indexPath.row];
    cell.model = model;

    return cell;
}


#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.sectionHeaderView.sectionModel = self.datas[section];
    
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



#pragma mark - <lazy>
- (ZXKJRankingDetailsSectionHeaderView *)sectionHeaderView
{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [ZXKJRankingDetailsSectionHeaderView viewFromNib];
        _sectionHeaderView.backgroundColor = kRedColor;
        _sectionHeaderView.frame = kRect(0, 0, kScreenWidth, 35);
    }
    return _sectionHeaderView;
}

@end
