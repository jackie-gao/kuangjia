//
//  ZXKJNavigationController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJNavigationController.h"
#import "LSNavigationBar.h"

@interface ZXKJNavigationController ()<UINavigationControllerDelegate>
/** 保存滑动返回代理*/
@property(nonatomic,strong) id popDelegate;

@end

@implementation ZXKJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}



#pragma mark - 自定义push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断是否是非根控制器
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalRenderingImageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}



#pragma mark - <action>
#pragma mark <buttonAction>
- (void)back
{
    [self popViewControllerAnimated:YES];
}



#pragma mark - <delegate>
#pragma mark <UINavigationControllerDelegate>
// 完全展示某个控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController ==[self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

@end
