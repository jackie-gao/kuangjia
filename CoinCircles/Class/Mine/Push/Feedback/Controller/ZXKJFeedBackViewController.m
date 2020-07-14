//
//  ZXKJFeedBackViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/2.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJFeedBackViewController.h"
#import "ZXKJFeedbackCell.h"

@interface ZXKJFeedBackViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,weak) ZXKJFeedbackCell *cell;

@end

@implementation ZXKJFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.cell setupKeyboard];
}



#pragma mark - <setupBasic>
- (void)setupBasic
{
    self.customNavigationBar.title = @"意见反馈";
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJFeedbackCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJFeedbackCell class])];
    self.tableView.rowHeight = 360;
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
    ZXKJFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJFeedbackCell class])];
    self.cell = cell;
    cell.submitBlock = ^(NSString * _Nonnull text) {
        [weak_self feedbackWithText:text];
    };
    
    return cell;
}



#pragma mark - <method>
/// 意见反馈
- (void)feedbackWithText:(NSString *)text
{
    kWeakSelf(self);
    NSMutableDictionary *params = [@{} mutableCopy];
    params[@"text"] = text;
    [LSMaskTool showLoadWithMaskAndMessage:@"提交中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LSMaskTool dismiss];
        
        UIAlertController *alectVC = [UIAlertController alertControllerWithTitle:@"意见反馈提交成功，谢谢您的参与" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *nextAlert = [UIAlertAction actionWithTitle:@"继续吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.cell emputTextView];
        }];
        UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weak_self.navigationController popViewControllerAnimated:YES];
        }];
        [alectVC addAction:nextAlert];
        [alectVC addAction:backAction];
        [weak_self presentViewController:alectVC animated:YES completion:nil];
    });
}

@end
