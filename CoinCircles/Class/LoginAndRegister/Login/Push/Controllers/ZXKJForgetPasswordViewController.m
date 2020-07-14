//
//  ZXKJForgetPasswordViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/3.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJForgetPasswordViewController.h"
#import "ZXKJForgetPasswordCell.h"

@interface ZXKJForgetPasswordViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJForgetPasswordCell *cell;

@end

@implementation ZXKJForgetPasswordViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJForgetPasswordCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJForgetPasswordCell class])];
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
    ZXKJForgetPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJForgetPasswordCell class])];
    self.cell = cell;
    cell.resetPasswordBlock = ^(NSString * _Nonnull phonenum, NSString * _Nonnull neoPasswordStr) {
        [weak_self resetPasswordWithPhoneNum:phonenum neoPassword:neoPasswordStr];
    };
    
    return cell;
}



#pragma mark - <method>
// 更换登录密码
- (void)resetPasswordWithPhoneNum:(NSString *)phoneNum neoPassword:(NSString *)neoPassword
{
    kWeakSelf(self);
    [LSMaskTool showLoad];
    self.tableView.userInteractionEnabled = NO;
    
    kDispatch_after(0.5, ^{
        weak_self.tableView.userInteractionEnabled = YES;
        if ([neoPassword isEqualToString:kUserDefaultsGetStringWithKey(ZCKJPasswordKey)]) {
            [LSMaskTool showErrorMessage:@"账号或密码错误"];
            return;
        }
        [LSMaskTool showSucceessMessage:@"重置成功"];
        kUserDefaultsSetValueAndKey(phoneNum, ZCKJMobileKey)
        kUserDefaultsSetValueAndKey(neoPassword, ZCKJPasswordKey);
        kPostNotification(ZXKJUpdateInfoKey);
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
