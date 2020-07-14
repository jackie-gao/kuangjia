//
//  ZXKJTabBarController.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJTabBarController.h"
#import "ZXKJNavigationController.h"
#import "ZXKJNewsViewController.h"              // 讯息
#import "ZXKJMarketViewController.h"            // 上榜
#import "ZXKJCommunityViewController.h"         // 圈子
#import "ZXKJMineViewController.h"              // 我的

@interface ZXKJTabBarController ()
@property(nonatomic,strong) NSArray *dictArr;

@end

@implementation ZXKJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
}



#pragma mark - <initialize>
+ (void)initialize
{
    // 设置文字的颜色
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    atts[NSForegroundColorAttributeName] = kRGBColor(153, 153, 153);
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *selectedAtts = [NSMutableDictionary dictionary];
    selectedAtts[NSFontAttributeName] = atts[NSFontAttributeName];
    selectedAtts[NSForegroundColorAttributeName] = kTintColor;
    selectedAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // 通过appearance统一设置tabBarItem的文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
}



#pragma mark - <addChildController>
- (void)setupChildViewController
{
    for (NSInteger i = 0; i < self.dictArr.count; i++) {
        NSDictionary *dict = self.dictArr[i];
        [self addChildViewController:[[dict[@"vc"] alloc]init]
                               title:dict[@"title"]
                          imageNamed:dict[@"imageNamed"]];
    }
}



#pragma mark - <method>
/// 添加子控制器
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    vc.navigationItem.title = title;

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageNamed];
    vc.tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingImageNamed:[imageNamed stringByAppendingString:@"_select"]];

    ZXKJNavigationController *navVC = [[ZXKJNavigationController alloc]initWithRootViewController:vc];

    [self addChildViewController:navVC];
    
}



#pragma mark - <lazy>
- (NSArray *)dictArr
{
    if (!_dictArr) {
        _dictArr = @[
                    @{
                        @"vc" : [ZXKJCommunityViewController class],
                        @"title": @"圈子",
                        @"imageNamed" : @"tabbar_reservation"
                        },
                     @{
                         @"vc" : [ZXKJNewsViewController class],
                         @"title": @"讯息",
                         @"imageNamed" : @"tabbar_home_page"
                         },
                     @{
                         @"vc" : [ZXKJMarketViewController class],
                         @"title": @"上榜",
                         @"imageNamed" : @"tabbar_mall"
                         },
                     @{
                         @"vc" : [ZXKJMineViewController class],
                         @"title": @"我的",
                         @"imageNamed" : @"tabbar_mine"
                         }
                     ];
    }
    return _dictArr;
}

@end
