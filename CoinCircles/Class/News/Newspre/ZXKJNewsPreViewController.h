//
//  ZXKJNewsPreViewController.h
//  CoinCircles
//
//  Created by Larson on 2020/7/13.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsPreViewController : UIViewController
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
