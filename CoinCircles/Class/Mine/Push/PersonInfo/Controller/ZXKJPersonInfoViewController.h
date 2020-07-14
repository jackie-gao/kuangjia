//
//  ZXKJPersonInfoViewController.h
//  CoinCircles
//
//  Created by Larson on 2020/7/9.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJBaseViewController.h"

@interface ZXKJPersonInfoViewController : ZXKJBaseViewController
// 修改成功
@property(nonatomic,copy) void(^modifySuccessBlock)(UIImage *image);

@end
