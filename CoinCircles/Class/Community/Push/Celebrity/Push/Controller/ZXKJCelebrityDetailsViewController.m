//
//  ZXKJCelebrityDetailsViewController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCelebrityDetailsViewController.h"
#import "ZXKJCelebrityDetailsCell.h"
#import "ZXKJCelebrityModel.h"

@interface ZXKJCelebrityDetailsViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet ZXKJBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property(nonatomic,strong) UIButton *attentionButton;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSData *imageData;
@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,assign) BOOL isCancelAttention;

@end

@implementation ZXKJCelebrityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LSMaskTool showLoad];
    kDispatch_after(0.5, ^{
        [LSMaskTool dismiss];
        [self setupNavBar];
        [self setupBasic];
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.isCancelAttention) {
        !self.cancelAttentionBlock ? : self.cancelAttentionBlock();
    }
}



#pragma mark - <setupNavigationBar>
- (void)setupNavBar
{
    self.customNavigationBar.title = self.model.title;
    [self.customNavigationBar addSubview:self.attentionButton];
    
    self.attentionButton.selected = [[LSDataBase sharedDataBase] checkDataExistsWithTableName:ZCKJCelebrityKey IDName:@"ID" ID:self.model.ID];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.view.backgroundColor = kWhiteColor;
    self.tableViewTopCons.constant = kHeightNavigationBar;
    
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXKJCelebrityDetailsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZXKJCelebrityDetailsCell class])];
    self.tableView.rowHeight = self.cellHeight;
    
    self.isCancelAttention = NO;
}



#pragma mark - <action>
// 收藏
- (void)collectionButtonAction:(UIButton *)sender
{
    if (![LSLoginTool checkLoginState]) {
        [LSLoginTool doLoginViewController];
        return;
    }
    
    [LSMaskTool showLoad];
    kDispatch_after(0.25, ^{
        if (sender.selected) { // 已经收藏
        [[LSDataBase sharedDataBase] delectCelebrityDataWithID:self.model.ID];
        [LSMaskTool showSucceessMessage:@"取消收藏成功"];
            self.isCancelAttention = YES;
        sender.selected = NO;
        }
        else { // 没有收藏
            [[LSDataBase sharedDataBase] insertCelebrityData:self.model];
            [LSMaskTool showSucceessMessage:@"收藏成功"];
            sender.selected = YES;
        }
    });
}



#pragma mark - <delegate>
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXKJCelebrityDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXKJCelebrityDetailsCell class])];
    cell.image = self.image;
    cell.model = self.model;
    
    return cell;
}



#pragma mark - <lazy>
- (UIButton *)attentionButton
{
    if (!_attentionButton) {
        CGFloat buttonWH = 30;
        CGFloat x = kScreenWidth - buttonWH - 10;
        CGFloat y = (kHeightNavigationBar - kHeightStatusBar - buttonWH) / 2 + kHeightStatusBar;
        _attentionButton = [[UIButton alloc]initWithFrame:kRect(x, y, buttonWH, buttonWH)];
        [_attentionButton setImage:[UIImage imageNamed:@"nav_attention_nor"] forState:UIControlStateNormal];
        [_attentionButton setImage:[UIImage imageNamed:@"nav_attention_sel"] forState:UIControlStateSelected];
        [_attentionButton addTarget:self action:@selector(collectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionButton;
}

- (NSData *)imageData
{
    if (!_imageData) {
        _imageData = [NSData dataWithContentsOfURL:kUrl(self.model.image)];
    }
    return _imageData;
}

- (UIImage *)image
{
    if (!_image) {
        UIImage *originalImage = [UIImage imageWithData:self.imageData];
        _image = [originalImage imageCompressForWidth:originalImage targetWidth:kScreenWidth - 20];
    }
    return _image;
}

- (CGFloat )cellHeight
{
    if (!_cellHeight) {
        CGFloat textHeight = [self.model.content getTextHeightWithViewWidth:kScreenWidth - 20 textFont:kFont(14)];
        _cellHeight = self.image.size.height + 10 + textHeight + 20;
    }
    return _cellHeight;
}

@end
