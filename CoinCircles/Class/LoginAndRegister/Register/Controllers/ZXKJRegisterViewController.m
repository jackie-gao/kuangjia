//
//  ZXKJRegisterViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJRegisterViewController.h"
#import "ZXKJRegisterCell.h"

@interface ZXKJRegisterViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJRegisterCell *cell;

@end

@implementation ZXKJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.cell setupKeyboard];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJRegisterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJRegisterCell class])];
    self.tableView.rowHeight = kScreenHeight - kHeightNavigationBar;
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
    ZXKJRegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJRegisterCell class])];
    self.cell = cell;
    cell.registerBlock = ^(NSString * _Nonnull phoneNumStr, NSString * _Nonnull passwordStr, NSString * _Nonnull inviteCodeStr) {
        [weak_self confirmRegisterWithPhoneNum:phoneNumStr password:passwordStr inviteCode:inviteCodeStr];
    };
    
    return cell;
}



#pragma mark - <method>
/// 确定注册
- (void)confirmRegisterWithPhoneNum:(NSString *)phoneNum password:(NSString *)password inviteCode:(NSString *)inviteCode
{
    kWeakSelf(self);
    [LSMaskTool showLoad];
    self.tableView.userInteractionEnabled = NO;
    
    kDispatch_after(0.5, ^{
        weak_self.tableView.userInteractionEnabled = YES;
        if ([phoneNum isEqualToString:kUserDefaultsGetStringWithKey(ZCKJMobileKey)]) {
            [LSMaskTool showErrorMessage:@"该账号已注册"];
            return;
        }
        [LSMaskTool showSucceessMessage:@"注册成功"];
        kUserDefaultsSetValueAndKey(phoneNum, ZCKJMobileKey);
        kUserDefaultsSetValueAndKey(password, ZCKJPasswordKey);
        kPostNotification(ZXKJUpdateInfoKey);
        [weak_self.navigationController popViewControllerAnimated:YES];
    });
}

@end
