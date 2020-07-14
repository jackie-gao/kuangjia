//
//  ZXKJCommunityViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/6.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityViewController.h"
#import "ZXKJCommunityHeaderView.h"
#import "ZXKJCommunityCell.h"
#import "ZXKJCommunityModel.h"
#import "ZXKJCommunityDetailsViewController.h"          // 详情
#import "ZXKJCommentViewController.h"                   // 评论
#import "ZXKJCommunityAgreementView.h"                  // 圈子协议

@interface ZXKJCommunityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) UIButton *commentButton;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,weak) ZXKJCommunityHeaderView *headerV;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) NSString *filePath;
@property(nonatomic,strong) ZXKJCommunityCell *cell;
/** 举报的下标*/
@property(nonatomic,strong) NSMutableArray *reportArr;

@end

@implementation ZXKJCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self loadData];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"圈子";
    
    [self.view insertSubview:self.commentButton aboveSubview:self.tableView];
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJCommunityCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJCommunityCell class])];
}



#pragma mark - <laod data>
- (void)loadData
{
    kWeakSelf(self);
    [LSMaskTool showLoad];
    kDispatch_after(1, ^{
        [LSMaskTool dismiss];
        weak_self.commentButton.hidden = NO;
        weak_self.datas = [ZXKJCommunityModel mj_objectArrayWithFile:self.filePath];
        weak_self.tableView.tableHeaderView = self.headerView;
        [weak_self.tableView reloadData];
        
        if (!kUserDefaultsGetBoolWithKey(ZCKJCommunityAgreemenKey)) {
            kDispatch_once_block(^{
                // 圈子协议
                kUserDefaultsSetBoolValueAndKey(YES, ZCKJCommunityAgreemenKey);
                [LSCover showWithDissmissBlock:nil];
                [ZXKJCommunityAgreementView showInfoWithLoadHTML:@"communityAgreemen.html" agreeBlock:nil];
            })
        }
    });
}



#pragma mark - <action>
// 发帖子
- (void)commentButtonAction
{
    // 检测是否登录
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    ZXKJCommentViewController *commentVC = ZXKJCommentViewController.alloc.init;
    [self.navigationController pushViewController:commentVC animated:YES];
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(self);
    ZXKJCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJCommunityCell class])];
    self.cell = cell;
    cell.model = self.datas[indexPath.row];
    // 屏蔽
    cell.shieldBlock = ^(NSInteger index) {
        [weak_self.datas removeObjectAtIndex:index];
        [weak_self.tableView reloadData];
    };
    // 举报
    cell.reportBlock = ^(NSInteger index) {
        [weak_self.reportArr addObject:@(index)];
    };

    return cell;
}

#pragma mark <UITableViewDelegate>
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCommunityModel *model = self.datas[indexPath.row];
    
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 是否被举报
    if (self.reportArr.count) {
        for (NSInteger i = 0; i < self.reportArr.count; i++) {
            if ([self.reportArr[i] integerValue] == indexPath.row) {
                [LSMaskTool showInfoMessage:@"该内容正在重新审核中!"];
                return;
            }
        }
    }
    
    ZXKJCommunityDetailsViewController *communityVC = ZXKJCommunityDetailsViewController.alloc.init;
    communityVC.model = self.datas[indexPath.row];
    [self.navigationController pushViewController:communityVC animated:YES];
}



#pragma mark - <lazy>
- (UIView *)headerView
{
    if (!_headerView) {
        ZXKJCommunityHeaderView *headerV = [ZXKJCommunityHeaderView viewFromNib];
        headerV.autoresizingMask = NO;
        headerV.frame = kRect(0, 0, kScreenWidth, 210);
        _headerView = [[UIView alloc]initWithFrame:headerV.bounds];
        self.headerV = headerV;
        [self.headerView addSubview:headerV];
    }
    return _headerView;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        CGFloat width = 45;
        CGFloat height = width;
//        UIImage *image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, width, height) andColors:@[kRGBColor(30, 180, 165), kRGBColor(30, 170, 190)] andGradientType:1];
         UIImage *image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kHeightNavigationBar) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.LS_width = width;
        _commentButton.LS_height = height;
        _commentButton.LS_x = kScreenWidth - 8 - width;
        _commentButton.LS_y = kScreenHeight - kHeightNavigationBar - kHeightTabbar;
        _commentButton.titleLabel.font = kFont(16);
        _commentButton.layer.cornerRadius = height / 2;
        _commentButton.layer.masksToBounds = YES;
        _commentButton.hidden = YES;
        [_commentButton setBackgroundImage:image forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

- (NSString *)filePath
{
    if (!_filePath) {
        _filePath = [[NSBundle mainBundle]pathForResource:@"community.plist" ofType:nil];
    }
    return _filePath;
}

- (NSMutableArray *)reportArr
{
    if (!_reportArr) {
        _reportArr = [@[] mutableCopy];
    }
    return _reportArr;
}

@end
