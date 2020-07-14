//
//  ZXKJCommunityDetailsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityDetailsViewController.h"
#import "ZXKJCommunityDetailsHeaderView.h"
#import "ZXKJCommunityDetailsCell.h"
#import "ZXKJCommunityModel.h"
#import "ZXKJCommunityDetailsModel.h"

@interface ZXKJCommunityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,weak) ZXKJCommunityDetailsHeaderView *headerV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolHeightCons;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,strong) NSMutableArray *datas;

@end

@implementation ZXKJCommunityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self loadData];
}


#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = @"详情";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    self.bottomToolHeightCons.constant = IS_LiuHai_Screen ? 50 + kHeightBottomSafe : 50;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJCommunityDetailsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJCommunityDetailsCell class])];
    
    [self commentTextFieldAction:self.textField];
}



#pragma mark - <laod data>
- (void)loadData
{
    [LSMaskTool load];
    kDispatch_after(0.5, ^{
        [LSMaskTool dismiss];
        self.tableView.tableHeaderView = self.headerView;
        [self.tableView reloadData];
    });
}



#pragma mark - <action>
#pragma mark <buttonAction>
- (IBAction)sendButtonAction:(id)sender {
    [self sendComment];
}

#pragma mark <textFieldAction>
- (IBAction)commentTextFieldAction:(id)sender {
    if (self.textField.text.length != 0) {
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = kRGBColor(240, 200, 50);
    } else {
        self.sendButton.enabled = NO;
        self.sendButton.backgroundColor = kRGBColor(153, 153, 153);
    }
}


#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCommunityDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJCommunityDetailsCell class])];

    return cell;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textField endEditing:YES];
}



#pragma mark - <Method>
/// 发送评论
- (void)sendComment
{
    NSString *commentStr = self.textField.text;
    if ([commentStr isContainsEmoji]) {
        [LSMaskTool showInfoMessage:@"不能包含表情"];
        return;
    }
    
    [LSMaskTool showLoad];
    kDispatch_after(0.5, ^{
        [self.textField endEditing:YES];
        [LSMaskTool dismiss];
        ZXKJCommunityDetailsModel *model = [ZXKJCommunityDetailsModel modelWithUsername:kUserDefaultsGetStringWithKey(ZCKJNicknameKey) content:commentStr time:[NSDate getCurrentTimes]];
        [self.datas addObject:model];
        [self.tableView reloadData];
    });
}



#pragma mark - <lazy>
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [@[] mutableCopy];
    }
    return _datas;
}

- (UIView *)headerView
{
    if (!_headerView) {
        CGFloat textHeight = [self.model.content getTextHeightWithViewWidth:kScreenWidth - 15 * 2 textFont:kFont(14)];
        CGFloat height = textHeight + self.model.imageHeight + 155;
        ZXKJCommunityDetailsHeaderView *headerV = [ZXKJCommunityDetailsHeaderView viewFromNib];
        headerV.autoresizingMask = NO;
        headerV.frame = kRect(0, 0, kScreenWidth, height);
        headerV.model = self.model;
        _headerView = [[UIView alloc]initWithFrame:headerV.bounds];
        self.headerV = headerV;
        [self.headerView addSubview:headerV];
    }
    return _headerView;
}

@end
