//
//  ZXKJAboutViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJAboutViewController.h"
#import "ZXKJAboutCell.h"

@interface ZXKJAboutViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;

@end

@implementation ZXKJAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"关于";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJAboutCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJAboutCell class])];
    self.tableView.rowHeight = kRelativityHeight(160) + 98;
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJAboutCell class])];
    return cell;
}

@end
