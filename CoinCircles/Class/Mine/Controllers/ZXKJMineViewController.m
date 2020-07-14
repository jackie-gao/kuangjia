//
//  ZXKJMineViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJMineViewController.h"
#import "ZCKJMineHeaderView.h"
#import "ZCKJMineCell.h"
#import "ZXKJMineHeaderViewModel.h"
#import "ZCKJMineModel.h"
#import "ZCKJMineGroupModel.h"
#import "ZXKJMyCollectionViewController.h"          // 收藏
#import "ZXKJAttentionViewController.h"             // 关注
#import "ZXKJHelpViewController.h"                  // 帮助
#import "ZXKJFeedBackViewController.h"              // 建议
#import "ZXKJAboutViewController.h"                 // 关于
#import "ZXKJSettingViewController.h"               // 设置

@interface ZXKJMineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
/** headerView*/
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,weak) ZCKJMineHeaderView *headerV;
@property(nonatomic,strong) UIImageView *headerBGImageView;
@property(nonatomic,strong) ZXKJMineHeaderViewModel *headerViewModel;
/** 内容信息*/
@property(nonatomic,strong) NSArray *infoArr;
/** 模型数据*/
@property(nonatomic,strong) NSMutableArray *datas;
/** 数据的下标*/
@property(nonatomic,assign) NSInteger dataIndex;

@end

@implementation ZXKJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupGroupZero];
    [self setupGroupFirst];
    [self setupGroupSecond];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.dataIndex = 0;
    
    self.customNavigationBar.hidden = YES;
    [self LS_setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.tableView insertSubview:self.headerBGImageView atIndex:0];
    
    self.tableViewTopCons.constant = -kHeightStatusBar;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    self.headerV.headerViewModel = self.headerViewModel;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCKJMineCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCKJMineCell class])];
    
    kAddNotificationWithSelectorAndName(self, loginSuccessNotificationAction, ZXKJLoginSucceedKey);
    kAddNotificationWithSelectorAndName(self, LoginOutSuccessNotificationAction, ZXKJLoginOutSucceedKey);
}



#pragma mark - <datas>
// zero section
- (void)setupGroupZero
{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < 2; i++) {
        ZCKJMineModel *model = [ZCKJMineModel modelWithDict:self.infoArr[i]];
        [tempArr addObject:model];
        self.dataIndex++;
    }
    ZCKJMineGroupModel *groupModel = [ZCKJMineGroupModel groupModelWithModel:tempArr];
    [self.datas addObject:groupModel];
}

// first section
- (void)setupGroupFirst
{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < 3; i++) {
        ZCKJMineModel *model = [ZCKJMineModel modelWithDict:self.infoArr[self.dataIndex]];
        [tempArr addObject:model];
        self.dataIndex++;
    }
    ZCKJMineGroupModel *groupModel = [ZCKJMineGroupModel groupModelWithModel:tempArr];
    [self.datas addObject:groupModel];
}

// second section
- (void)setupGroupSecond
{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < 2; i++) {
        ZCKJMineModel *model = [ZCKJMineModel modelWithDict:self.infoArr[self.dataIndex]];
        [tempArr addObject:model];
        self.dataIndex++;
    }
    ZCKJMineGroupModel *groupModel = [ZCKJMineGroupModel groupModelWithModel:tempArr];
    [self.datas addObject:groupModel];
}



#pragma mark - <action>
#pragma mark <notificationAction>
// 登录成功
- (void)loginSuccessNotificationAction
{
    self.headerV.headerViewModel = self.headerViewModel;
}

// 退出登录
- (void)LoginOutSuccessNotificationAction
{
    self.headerV.headerViewModel = self.headerViewModel;
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZCKJMineGroupModel *groupModel = self.datas[section];

    return groupModel.groupModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCKJMineGroupModel *groupModel = self.datas[indexPath.section];

    ZCKJMineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCKJMineCell class])];
    ZCKJMineModel *model = groupModel.groupModels[indexPath.row];
    cell.model = model;
    cell.separatorLineHidden = (indexPath.row == groupModel.groupModels.count - 1) ? YES : NO;

    return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {        // 意见反馈
        ZXKJFeedBackViewController *feedBackVC = ZXKJFeedBackViewController.alloc.init;
        [self.navigationController pushViewController:feedBackVC animated:YES];
        return;
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {        // 联系客服
        NSString *phone = [[NSString alloc]initWithFormat:@"tel:%@", @"4007160888"];
        NSURL *url = [NSURL URLWithString:phone];
        CGFloat devieceVersion = UIDevice.currentDevice.systemVersion.floatValue;
        if (devieceVersion >= 10.0) {
            [kApplication openURL:url options:@{} completionHandler:nil];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [kApplication openURL:url];
#pragma clang diagnostic pop
        }
        return;
    }
    else if (indexPath.section == 1 && indexPath.row == 2) {        // 推荐好用使用
        UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[@"快来一起用比特看看吧！",[UIImage imageNamed:@"no_data"],[NSURL URLWithString:@""]] applicationActivities:nil];
         UIPopoverPresentationController *popover = activity.popoverPresentationController;
         if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
          }
        [self presentViewController:activity animated:YES completion:NULL];
            return;
        }
    else if (indexPath.section == 2 && indexPath.row == 0) {
        ZXKJAboutViewController *AboutVC = ZXKJAboutViewController.alloc.init;
        [self.navigationController pushViewController:AboutVC animated:YES];
        return;
    }
    
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    ZCKJMineGroupModel *groupModel = self.datas[indexPath.section];
    ZCKJMineModel *model = groupModel.groupModels[indexPath.row];
    // 跳转
    if ([model isKindOfClass:[ZCKJMineModel class]] && model.detailsVC) {
        UIViewController *vc = [[model.detailsVC alloc]init];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZCKJMineCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


#pragma mark - <lazy>
- (UIView *)headerView
{
    if (!_headerView) {
        CGFloat height = kRelativityHeight(190);
        ZCKJMineHeaderView *headerV = [ZCKJMineHeaderView viewFromNib];
        headerV.autoresizingMask = NO;
        headerV.frame = kRect(0, 0, kScreenWidth, height);
        _headerView = [[UIView alloc]initWithFrame:headerV.bounds];
        self.headerV = headerV;
        [self.headerView addSubview:headerV];
    }
    return _headerView;
}

- (UIImageView *)headerBGImageView
{
    if (!_headerBGImageView) {
        _headerBGImageView = [[UIImageView alloc] init];
        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        CGRect offsetRect = CGRectOffset(rect, 0, -kScreenHeight);
        _headerBGImageView.frame = offsetRect;
        _headerBGImageView.image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, kScreenWidth, kRelativityHeight(190)) andColors:@[kRGBColor(221, 178, 109), kRGBColor(246, 242, 196)] andGradientType:1];
    }
    return _headerBGImageView;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [@[] mutableCopy];
    }
    return _datas;
}

- (ZXKJMineHeaderViewModel *)headerViewModel
{
    _headerViewModel = [ZXKJMineHeaderViewModel modelWithAvatar:[NSString stringWithFormat:@"%@", kUserDefaultsGetStringWithKey(ZCKJAvatarKey)] mobile:kUserDefaultsGetStringWithKey(ZCKJMobileKey) nickname:kUserDefaultsGetStringWithKey(ZCKJNicknameKey)];
    
    return _headerViewModel;
}

- (NSArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = @[
                    @{
                        @"title" : @"收藏",
                        @"imageNamed" : @"mine_collect",
                        @"detailsVC" : [ZXKJMyCollectionViewController class]
                        },
                     @{
                         @"title" : @"关注",
                         @"imageNamed" : @"mine_attention",
                         @"detailsVC" : [ZXKJAttentionViewController class]
                         },
                    @{
                        @"title" : @"建议",
                        @"imageNamed" : @"mine_suggest",
                        @"detailsVC" : [ZXKJFeedBackViewController class]
                        },
                    @{
                        @"title" : @"联系我们",
                        @"imageNamed" : @"mine_contact"
                    },
                    @{
                        @"title" : @"分享好友",
                        @"imageNamed" : @"mine_recommend"
                    },
                     @{
                         @"title" : @"关于",
                         @"imageNamed" : @"mine_about",
                         @"detailsVC" : [ZXKJAboutViewController class]
                         },
                     @{
                         @"title" : @"设置",
                         @"imageNamed" : @"mine_setting",
                         @"detailsVC" : [ZXKJSettingViewController class]
                         }
                     ];
    }
    return _infoArr;
}



#pragma mark - <systemMethod>
- (void)dealloc
{
    kRemoveNotification(self);
}

@end
