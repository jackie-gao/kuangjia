//
//  ZXKJCommentViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommentViewController.h"
#import "ZXKJCommentCell.h"
#import "ZXKJCommentModel.h"

@interface ZXKJCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) ZXKJCommentCell *cell;

@end

@implementation ZXKJCommentViewController

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
    self.customNavigationBar.title = @"帖子发布";
    
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJCommentCell class])];
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
    ZXKJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJCommentCell class])];
    self.cell = cell;
    cell.releaseBlock = ^(ZXKJCommentModel * _Nonnull model) {
        [LSMaskTool load];
        if (model.images.count == 0) {
            kDispatch_after(0.5, ^{
                [LSMaskTool showSucceessMessage:@"审核成功即可发布"];
                [weak_self.navigationController popViewControllerAnimated:YES];
            });
        }
        else {
            kDispatch_after(1.5, ^{
                [LSMaskTool showSucceessMessage:@"审核成功即可发布"];
                [weak_self.navigationController popViewControllerAnimated:YES];
            });
        }
    };

    return cell;
}


#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCommentModel *model = ZXKJCommentModel.alloc.init;
    
    return model.cellHeight;
}

@end
