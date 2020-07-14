//
//  ZXKJNewsDetailsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNewsDetailsViewController.h"
#import "ZXKJNewsDetailsHeaderView.h"
#import "ZXKJNewsDetailsCell.h"
#import "ZXKJNewsModel.h"
#import "ZXKJNewsDetailsModel.h"

@interface ZXKJNewsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property (weak, nonatomic) IBOutlet UIView *commentBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolHeightCons;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) ZXKJNewsDetailsHeaderView *headerV;
// 导航栏右边的view
@property(nonatomic,strong) UIView *navBarRightView;
@property(nonatomic,weak) UIButton *collectionButton;
@property(nonatomic,weak) UIButton *shareButton;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,assign) BOOL isLoad;
@property(nonatomic,assign) BOOL isCancelCollect;

@end

@implementation ZXKJNewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupBasic];
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.isCancelCollect) {
        !self.cancelCollectBlock ? : self.cancelCollectBlock();
    }
}



#pragma mark - <setupNavigationBar>
- (void)setupNavBar
{
    self.customNavigationBar.title = self.customNavigationBar.title = self.model.title;
    [self.customNavigationBar addSubview:self.navBarRightView];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.tableViewTopCons.constant = kHeightNavigationBar;
    self.bottomToolHeightCons.constant = IS_LiuHai_Screen ? 50 + kHeightBottomSafe : 50;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJNewsDetailsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJNewsDetailsCell class])];
    
    kWeakSelf(self);
    self.headerV.contentHeightBlock = ^(CGFloat contentHeight) {
        weak_self.headerView.LS_height = contentHeight;
    };
    
    [self commentTextFieldAction:self.textField];
    self.isLoad = NO;
    self.isCancelCollect = NO;
}



#pragma mark - <laod data>
- (void)loadData
{
    kWeakSelf(self);
    [LSMaskTool showLoad];
    kDispatch_after(1.5, ^{
        [LSMaskTool dismiss];
        weak_self.isLoad = YES;
        weak_self.commentBgView.hidden = NO;
        weak_self.tableView.tableHeaderView = self.headerView;
        [weak_self.tableView reloadData];
        weak_self.navBarRightView.userInteractionEnabled = YES;
        weak_self.collectionButton.selected = [[LSDataBase sharedDataBase] checkDataExistsWithTableName:ZCKJCollectKey IDName:@"ID" ID:self.model.ID];
    });
}



#pragma mark - <action>
#pragma mark <buttonAction>
// collect
- (void)collectionButtonAction:(UIButton *)sender
{
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    kWeakSelf(self);
    [LSMaskTool showLoad];
    kDispatch_after(0.25, ^{
        if (sender.selected) { // 已经收藏
            [[LSDataBase sharedDataBase] delectCollectDataWithID:self.model.ID];
            sender.selected = NO;
            [LSMaskTool showSucceessMessage:@"取消收藏成功"];
            weak_self.isCancelCollect = YES;
        }
        else {             // 没有收藏
            [[LSDataBase sharedDataBase] insertCollectData:self.model];
            sender.selected = YES;
            [LSMaskTool showSucceessMessage:@"收藏成功"];
        }
    });
}

// share
- (void)shareButtonAction:(UIButton *)sender
{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[self.model.title,[UIImage imageNamed:@"mine_icon"],[NSURL URLWithString:self.model.sourceUrl]] applicationActivities:nil];
     UIPopoverPresentationController *popover = activity.popoverPresentationController;
     if (popover) {
        popover.sourceView = self.view;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
      }
    [self presentViewController:activity animated:YES completion:NULL];
}

// comment
- (IBAction)sendButtonAction {
    [self sendComment];
}


#pragma mark <textField action>
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
    return self.isLoad == YES ? self.datas.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJNewsDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJNewsDetailsCell class])];
    ZXKJNewsDetailsModel *model = self.datas[indexPath.row];
    cell.model = model;
    cell.separatorLineHidden = (indexPath.row == self.datas.count - 1) ? YES : NO;
    kWeakSelf(self);
    cell.deleteCommentBlock = ^(NSInteger index) {
        [LSMaskTool showSucceessMessage:@"删除成功"];
        [weak_self.datas removeObjectAtIndex:index];
        [tableView reloadData];
        [[LSDataBase sharedDataBase] delectNewsCommentDataWithTime:model.time];
    };

    return cell;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJNewsDetailsModel *model = self.datas[indexPath.row];
    
    return model.cellHeight;;
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
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    NSString *commentStr = self.textField.text;
    if ([commentStr isContainsEmoji]) {
        [LSMaskTool showInfoMessage:@"不能包含表情"];
        return;
    }
    
    kWeakSelf(self);
    [LSMaskTool showLoad];
    kDispatch_after(0.5, ^{
        [weak_self.textField endEditing:YES];
        [LSMaskTool showSucceessMessage:@"评论成功"];
        ZXKJNewsDetailsModel *model = [ZXKJNewsDetailsModel modelWithImageNamed:ZCKJLocatAvatarKey nickname:kUserDefaultsGetStringWithKey(ZCKJNicknameKey) time:[NSDate getCurrentTimes] content:commentStr];
        [[LSDataBase sharedDataBase] insertNewsCommentData:model];
        
//        [weak_self.datas insertObject:model atIndex:0];
        [weak_self.datas addObject:model];
        [weak_self.tableView reloadData];
        [weak_self.textField endEditing:YES];
        weak_self.textField.text = @"";
        [weak_self commentTextFieldAction:weak_self.textField];
        
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:self.datas.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:scrollIndexPath
        atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}



#pragma mark - <lazy>
- (UIView *)navBarRightView
{
    if (!_navBarRightView) {
        CGFloat width = 65;
        CGFloat height = 30;
        CGFloat x = kScreenWidth - width - 10;
        CGFloat y = (kHeightNavigationBar - kHeightStatusBar - height) / 2 + kHeightStatusBar;
        _navBarRightView = [[UIView alloc]initWithFrame:kRect(x, y, width, height)];
        [_navBarRightView addSubview:self.collectionButton];
        [_navBarRightView addSubview:self.shareButton];
        _navBarRightView.userInteractionEnabled = NO;
    }
    return _navBarRightView;
}

- (UIButton *)collectionButton
{
    if (!_collectionButton) {
        CGFloat buttonWH = 30;
        UIButton *button = [[UIButton alloc]initWithFrame:kRect(0, 0, buttonWH, buttonWH)];
        [button setImage:[UIImage imageNamed:@"nac_collect_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nac_collect_sel"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(collectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBarRightView addSubview:button];
        self.collectionButton = button;
    }
    return _collectionButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        CGFloat buttonWH = 30;
        UIButton *button = [[UIButton alloc]initWithFrame:kRect(self.collectionButton.LS_width + 5, 0, buttonWH, buttonWH)];
        [button setImage:[UIImage imageNamed:@"nav_share_nor"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBarRightView addSubview:button];
        self.shareButton  = button;
    }
    return _shareButton;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:kRect(0, 0, kScreenWidth, 500)];
        self.headerV.frame = _headerView.bounds;
        [_headerView addSubview:self.headerV];
    }
    return _headerView;
}

- (ZXKJNewsDetailsHeaderView *)headerV
{
    if (!_headerV) {
        _headerV = [ZXKJNewsDetailsHeaderView viewFromNib];
        _headerV.autoresizingMask = NO;
        _headerV.author = self.model.source;
        _headerV.time = self.model.gmtRelease;
        _headerV.content = self.model.content;
    }
    return _headerV;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        if ([[LSDataBase sharedDataBase] getAllNewsCommentData].count) {
            _datas = [NSMutableArray arrayWithArray:[[LSDataBase sharedDataBase] getAllNewsCommentData]];
        }
        else {
            _datas = [@[] mutableCopy];
        }
    }
    return _datas;
}

@end
