//
//  ZXKJPersonInfoViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJPersonInfoViewController.h"
#import "ZXKJPersonInfoCell.h"
#import "ZXKJPersonInfoModel.h"

@interface ZXKJPersonInfoViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJPersonInfoModel *model;

@end

@implementation ZXKJPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"个人信息";
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJPersonInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJPersonInfoCell class])];
    self.tableView.rowHeight = 190;
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJPersonInfoCell class])];
    cell.model = self.model;
    
    kWeakSelf(self);
    kWeakSelf(cell);
    // 头像
    cell.avatrBlock = ^(UIImage * _Nonnull image) {
        [weak_self changePersonInfWithChangedSuccess:^{
            [weak_self.tableView reloadData];
            !weak_self.modifySuccessBlock ? : self.modifySuccessBlock(image);
        }];
    };
    
    // 昵称
    cell.nickNameBlock = ^(NSString * _Nonnull nickName) {
        [weak_self changePersonInfWithChangedSuccess:^{
            weak_cell.model.nickname = nickName;
            [weak_self.tableView reloadData];
            kUserDefaultsSetValueAndKey(nickName, ZCKJNicknameKey);
            !weak_self.modifySuccessBlock ? : self.modifySuccessBlock(nil);
        }];
    };
    
    // 邮箱
    cell.emailBlock = ^(NSString * _Nonnull email) {
        [weak_self changePersonInfWithChangedSuccess:^{
            weak_cell.model.email = email;
            [weak_self.tableView reloadData];
            kUserDefaultsSetValueAndKey(email, ZCKJEmailKey);
        }];
    };
    
    return cell;
}



#pragma mark - <method>
/// 修改个人信息
- (void)changePersonInfWithChangedSuccess:(void (^)(void))changedSuccess
{
    [LSMaskTool showLoad];
    self.tableView.userInteractionEnabled = NO;
    kDispatch_after(0.5, ^{
        self.tableView.userInteractionEnabled = YES;
        [LSMaskTool showSucceessMessage:@"修改成功"];
        !changedSuccess ? : changedSuccess();
    });
}



#pragma mark - <lazy>
- (ZXKJPersonInfoModel *)model
{
    if (!_model) {
        _model = ZXKJPersonInfoModel.alloc.init;
        _model.avatar = kUserDefaultsGetStringWithKey(ZCKJAvatarKey);
        _model.nickname = kUserDefaultsGetStringWithKey(ZCKJNicknameKey);
        _model.mobile = kUserDefaultsGetStringWithKey(ZCKJMobileKey);
        _model.email = kUserDefaultsGetStringWithKey(ZCKJEmailKey);
    }
    return _model;
}

@end
