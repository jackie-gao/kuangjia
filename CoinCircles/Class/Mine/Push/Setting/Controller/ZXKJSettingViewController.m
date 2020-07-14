//
//  ZXKJSettingViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJSettingViewController.h"
#import "ZXKJSettingGroupModel.h"
#import "ZXKJSettingModel.h"
#import "ZXKJSettingCell.h"
#import "ZXKJModifyLoginPasswordViewController.h"           // 修改密码
#import "ZXKJUserAgreementViewController.h"                 // 用户协议
#import "ZXKJPrivacyPolicyViewController.h"                 // 隐私政策

@interface ZXKJSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
/** 内容信息*/
@property(nonatomic,strong) NSArray *infoArr;
@property(nonatomic,strong) NSMutableArray *datas;
/** 数据的下标*/
@property(nonatomic,assign) NSInteger dataIndex;
@property(nonatomic,strong) ZXKJSettingCell *cell;

@end

@implementation ZXKJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupGroupZero];
    [self setupGroupFirst];
}



#pragma mark - <setupBasic>
- (void)setupBasic
{
    self.customNavigationBar.title = @"设置";
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJSettingCell class])];
    self.tableView.rowHeight = 45;
}



#pragma mark - <datas>
#pragma mark - <datas>
// zero section
- (void)setupGroupZero
{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < 2; i++) {
        ZXKJSettingModel *model = [ZXKJSettingModel modelWithDict:self.infoArr[i]];
        [tempArr addObject:model];
        self.dataIndex++;
    }
    ZXKJSettingGroupModel *groupModel = [ZXKJSettingGroupModel groupModelWithModel:tempArr];
    [self.datas addObject:groupModel];
}

// first section
- (void)setupGroupFirst
{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < 2; i++) {
        ZXKJSettingModel *model = [ZXKJSettingModel modelWithDict:self.infoArr[self.dataIndex]];
        [tempArr addObject:model];
        self.dataIndex++;
    }
    ZXKJSettingGroupModel *groupModel = [ZXKJSettingGroupModel groupModelWithModel:tempArr];
    [self.datas addObject:groupModel];
}



#pragma mark - <action>
// 退出登录
- (IBAction)loginOutButtonAction {
    [self loginOut];
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZXKJSettingGroupModel *groupModel = self.datas[section];

    return groupModel.groupModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJSettingGroupModel *groupModel = self.datas[indexPath.section];

    ZXKJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJSettingCell class])];
    ZXKJSettingModel *model = groupModel.groupModels[indexPath.row];
    cell.model = model;
    cell.separatorLineHidden = (indexPath.row == groupModel.groupModels.count - 1) ? YES : NO;

    return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [LSSaveTool clearCache];
        [LSMaskTool showSucceessMessage:@"清理完成"];
        [self.tableView reloadData];
        return;
    }
    
    ZXKJSettingGroupModel *groupModel = self.datas[indexPath.section];
    ZXKJSettingModel *model = groupModel.groupModels[indexPath.row];
    // 跳转
    if ([model isKindOfClass:[ZXKJSettingModel class]] && model.detailsVC) {
        UIViewController *vc = [[model.detailsVC alloc]init];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}



#pragma mark - <method>
/// 退出登录
- (void)loginOut
{
    kWeakSelf(self);
    [LSAlertController AlertStyleAndTextFieldWithTitle:@"提示" message:@"您确定要退出登录吗?" fromVC:self completeBlock:^(NSString *inputValue) {
        [LSMaskTool showLoad];
        kDispatch_after(0.65, ^{
            [LSMaskTool dismiss];
            [LSSaveTool removeUserData];
            [weak_self.navigationController popToRootViewControllerAnimated:YES];
        });
        
    }];
}



#pragma mark - <lazy>
- (NSArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = @[
                    @{
                        @"title" : @"修改登录密码",
                        @"isShowIndicator" : [NSNumber numberWithBool:YES],
                        @"detailsVC" : [ZXKJModifyLoginPasswordViewController class]
                        },
                     @{
                        @"title" : @"清理缓存",
                        @"isShowIndicator" : [NSNumber numberWithBool:NO],
                        },
                    @{
                        @"title" : @"用户协议",
                        @"isShowIndicator" : [NSNumber numberWithBool:YES],
                        @"detailsVC" : [ZXKJUserAgreementViewController class]
                        },
                    @{
                        @"title" : @"隐私政策",
                        @"isShowIndicator" : [NSNumber numberWithBool:YES],
                        @"detailsVC" : [ZXKJPrivacyPolicyViewController class]
                        },
                     ];
    }
    return _infoArr;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [@[] mutableCopy];
    }
    return _datas;
}

@end
