//
//  ZXKJHeadlinesDetailsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/13.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJHeadlinesDetailsViewController.h"
#import "ZXKJHeadlinesDetailsHeaderView.h"
#import "ZXKJHeadlinesDetailsCell.h"
#import "ZXKJHeadlinesDetailsModel.h"
#import "ZXKJHeadlinesModel.h"

@interface ZXKJHeadlinesDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property (weak, nonatomic) IBOutlet UIView *commentBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolHeightCons;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) ZXKJHeadlinesDetailsHeaderView *headerV;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,assign) BOOL isLoad;

@end

@implementation ZXKJHeadlinesDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self loadData];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.customNavigationBar.title = self.customNavigationBar.title = self.model.title;
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    self.bottomToolHeightCons.constant = IS_LiuHai_Screen ? 50 + kHeightBottomSafe : 50;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJHeadlinesDetailsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJHeadlinesDetailsCell class])];
    
    kWeakSelf(self);
    self.headerV.contentHeightBlock = ^(CGFloat contentHeight) {
        weak_self.headerView.LS_height = contentHeight;
    };
    
    [self commentTextFieldAction:self.textField];
    self.isLoad = NO;
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
    });
}



#pragma mark - <action>
#pragma mark <buttonAction>
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
    ZXKJHeadlinesDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJHeadlinesDetailsCell class])];
    cell.model = self.datas[indexPath.row];
    cell.separatorLineHidden = (indexPath.row == self.datas.count - 1) ? YES : NO;
    kWeakSelf(self);
    cell.deleteCommentBlock = ^(NSInteger index) {
        NSLog(@"index - %ld", index);
        [LSMaskTool showSucceessMessage:@"删除成功"];
        [weak_self.datas removeObjectAtIndex:index];
        [tableView reloadData];
        [[LSDataBase sharedDataBase] delectHeadlineCommentDataWithID:index];
    };

    return cell;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJHeadlinesDetailsModel *model = self.datas[indexPath.row];
    
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
            ZXKJHeadlinesDetailsModel *model = [ZXKJHeadlinesDetailsModel modelWithID:self.datas.count imageNamed:ZCKJLocatAvatarKey nickname:kUserDefaultsGetStringWithKey(ZCKJNicknameKey) time:[NSDate getCurrentTimes] content:commentStr];
            [[LSDataBase sharedDataBase] insertHeadlineCommentData:model];
            
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
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:kRect(0, 0, kScreenWidth, 500)];
        self.headerV.frame = _headerView.bounds;
        [_headerView addSubview:self.headerV];
    }
    return _headerView;
}

- (ZXKJHeadlinesDetailsHeaderView *)headerV
{
    if (!_headerV) {
        _headerV = [ZXKJHeadlinesDetailsHeaderView viewFromNib];
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
        if ([[LSDataBase sharedDataBase] getAllHeadlineCommentData].count) {
            _datas = [NSMutableArray arrayWithArray:[[LSDataBase sharedDataBase] getAllHeadlineCommentData]];
        }
        else {
            _datas = [@[] mutableCopy];
        }
    }
    return _datas;
}

@end
