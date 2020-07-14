//
//  ZXKJModifyLoginPasswordViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJModifyLoginPasswordViewController.h"
#import "ZXKJModifyLoginPasswordCell.h"

@interface ZXKJModifyLoginPasswordViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,weak) ZXKJModifyLoginPasswordCell *cell;

@end

@implementation ZXKJModifyLoginPasswordViewController

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
    self.customNavigationBar.title = @"修改登录密码";
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJModifyLoginPasswordCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJModifyLoginPasswordCell class])];
    self.tableView.rowHeight = 165;
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
    ZXKJModifyLoginPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJModifyLoginPasswordCell class])];
    self.cell = cell;
    cell.modifyLoginPasswordBlock = ^(NSString * _Nonnull oldPassword, NSString * _Nonnull novelPassword) {
        [weak_self modifyPasswordWithOldpassword:oldPassword novelPassword:novelPassword];
    };

    return cell;
}



#pragma mark - <method>
// 更换登录密码
- (void)modifyPasswordWithOldpassword:(NSString *)oldPassword novelPassword:(NSString *)novelPassword
{
    
    kWeakSelf(self);
    [LSMaskTool showLoad];
    self.tableView.userInteractionEnabled = NO;
    
    kDispatch_after(0.5, ^{
        weak_self.tableView.userInteractionEnabled = YES;
        if (![oldPassword isEqualToString:kUserDefaultsGetStringWithKey(ZCKJPasswordKey)]) {
            [LSMaskTool showErrorMessage:@"密码错误"];
            return;
        }
        
        [LSMaskTool showSucceessMessage:@"修改成功"];
        kUserDefaultsSetValueAndKey(novelPassword, ZCKJPasswordKey);
        kPostNotification(ZXKJLoginOutSucceedKey);
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

@end
