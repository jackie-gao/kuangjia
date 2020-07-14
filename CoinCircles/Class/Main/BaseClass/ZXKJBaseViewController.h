//
//  ZXKJBaseViewController.h
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSNavigationBar.h"
#import "LSCustomNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJBaseViewController : UIViewController

/** 自定义的导航栏*/
@property(nonatomic,strong) LSCustomNavigationBar *customNavigationBar;

@end

NS_ASSUME_NONNULL_END
