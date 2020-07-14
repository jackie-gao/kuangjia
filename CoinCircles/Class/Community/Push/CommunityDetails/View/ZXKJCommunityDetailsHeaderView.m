//
//  ZXKJCommunityDetailsHeaderView.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJCommunityDetailsHeaderView.h"
#import "ZXKJCommunityModel.h"
#import "LSImageBrowserViewController.h"

@interface ZXKJCommunityDetailsHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *kTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureBgViewHeightCons;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thridImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property(nonatomic,strong) NSMutableArray *imageViews;

@end

@implementation ZXKJCommunityDetailsHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupBasic];
}



#pragma mark - <setup>
- (void)setupBasic
{
    self.pictureBgViewHeightCons.constant = (kScreenWidth - 15 * 4) / 3;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClickEvent:)];
    [self.firstImageView addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClickEvent:)];
    [self.secondImageView addGestureRecognizer:tapGesture2];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClickEvent:)];
    [self.thridImageView addGestureRecognizer:tapGesture3];
    [tapGesture1 requireGestureRecognizerToFail:tapGesture2];
    [tapGesture2 requireGestureRecognizerToFail:tapGesture3];
}



#pragma mark - <setter>
- (void)setModel:(ZXKJCommunityModel *)model
{
    _model = model;
    
    self.kTitleLabel.text = model.title;
    self.contentLabel.text = model.content;
    for (NSInteger i = 0; i < model.images.count; i++) {
        switch (i) {
            case 0:
                self.firstImageView.image = [UIImage imageNamed:model.images[i]];
                break;
                
                case 1:
                self.secondImageView.image = [UIImage imageNamed:model.images[i]];
                break;
                
                case 2:
                self.thridImageView.image = [UIImage imageNamed:model.images[i]];
                break;
                
            default:
                break;
        }
    }
    self.timeLabel.text = model.time;
}



#pragma mark - <action>
- (void)imageClickEvent:(UIGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)gesture.view;
    NSMutableArray *imageItems = [NSMutableArray array];
    NSInteger i = 0;
    
    for (NSString *imageNamed in self.model.images) {
        LSImageItem *imageItem = [[LSImageItem alloc]initWithSourceView:self.imageViews[i] localImage:[UIImage imageNamed:imageNamed]];
        [imageItems addObject:imageItem];
        i++;
    }
    
    LSImageBrowserViewController *imageBrowserVC = [[LSImageBrowserViewController alloc]initWithImageItems:imageItems selectedIndex:imageView.tag - 100];
    [imageBrowserVC showImageBrowser];
}



#pragma mark - <lazy>
- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [@[] mutableCopy];
        [_imageViews addObject:self.firstImageView];
        [_imageViews addObject:self.secondImageView];
        [_imageViews addObject:self.thridImageView];
    }
    return _imageViews;
}

@end
