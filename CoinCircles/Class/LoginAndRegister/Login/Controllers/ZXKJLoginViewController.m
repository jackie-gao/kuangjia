//
//  ZXKJLoginViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJLoginViewController.h"
#import "ZXKJLoginCell.h"

@interface ZXKJLoginViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJLoginCell *cell;

@end

@implementation ZXKJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupBasic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.cell setupKeyboard];
}



#pragma mark - <setupNavigationBar>
- (void)setupNavBar
{
    [self.customNavigationBar LS_setLeftButtonWithImage:[UIImage imageNamed:@"login_close"]];
    kWeakSelf(self);
    self.customNavigationBar.onClickLeftButton = ^{
        [weak_self dismissViewControllerAnimated:YES completion:nil];
    };
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJLoginCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJLoginCell class])];
    self.tableView.rowHeight = kScreenHeight - kHeightNavigationBar;
    
    kAddNotificationWithSelectorAndName(self, updateInfoNotificationAction, ZXKJUpdateInfoKey);
}



#pragma mark - <action>
#pragma mark <notificationAction>
// 注册成功
- (void)updateInfoNotificationAction
{
    self.cell.phoneNum = kUserDefaultsGetStringWithKey(ZCKJMobileKey);
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(self);
    ZXKJLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJLoginCell class])];
    self.cell = cell;
    // 登录
    cell.loginBlock = ^(NSString * _Nonnull phoneNum, NSString * _Nonnull password) {
        [weak_self loginWithPhoneNum:phoneNum password:password];
    };
    
    return cell;
}



#pragma mark - <method>
/// 登录
- (void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)password
{
    kWeakSelf(self);
    [LSMaskTool showLoad];
    self.tableView.userInteractionEnabled = NO;
    
    kDispatch_after(0.5, ^{
        weak_self.tableView.userInteractionEnabled = YES;
        if (!kUserDefaultsGetStringWithKey(ZCKJMobileKey)) {
            [LSMaskTool showErrorMessage:@"该账号未注册"];
            return;
        }
        else if (![phoneNum isEqualToString:kUserDefaultsGetStringWithKey(ZCKJMobileKey)] ||
        ![password isEqualToString:kUserDefaultsGetStringWithKey(ZCKJPasswordKey)])
        {
            [LSMaskTool showErrorMessage:@"账号或者密码错误"];
            return;
        }
        [LSMaskTool showSucceessMessage:@"登录成功"];
        kUserDefaultsSetValueAndKey(phoneNum, ZCKJMobileKey);
        kUserDefaultsSetValueAndKey(password, ZCKJTokenKey);
        kUserDefaultsSetValueAndKey(@"Zhdhja656", ZCKJNicknameKey);
        kUserDefaultsSetValueAndKey(@"mine_icon", ZCKJAvatarKey);
        kPostNotification(ZXKJLoginSucceedKey);
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}



#pragma mark - <systemMethod>
- (void)dealloc
{
    kRemoveNotification(self);
}

@end
