//
//  AppMarco+UIKit.h
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#ifndef AppMarco_UIKit_h
#define AppMarco_UIKit_h

#define kApplication                        UIApplication.sharedApplication
#define kKeyWindow                          UIApplication.sharedApplication.windows.firstObject
#define kRootViewController                 kKeyWindow.rootViewController
// 当前视图的容器控制器
#define kContainerVC(view)                  [view getCurrentViewForContainerController]

#define kScreenBounds                       [UIScreen mainScreen].bounds
#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height



// ============================== frame ============================== //
#define kRect(x, y, width, height)                      CGRectMake(x, y, width, height)
#define kPoint(x, y)                                    CGPointMake(x, y)
#define kSize(width, height)                            CGSizeMake(width, height)
#define kRange(loc, len)                                NSMakeRange(loc, len)
#define kRectOffset(rect, x, y)                         CGRectOffset(rect, x, y)
#define kEdgeInsets(top, left, bottom, right)           UIEdgeInsetsMake(top, left, bottom, right)
#define kIndexPath(index, section)                      [NSIndexPath indexPathForItem:index inSection:section]
#define kCLLocationCoordinate2D(latitude, longitude)    CLLocationCoordinate2DMake(latitude, longitude)



// ============================== 圆角和边框 ============================== //
#define kViewBorderRadius(view, radius, width, color)\
view.layer.cornerRadius = radius;\
view.layer.borderWidth = width;\
view.layer.borderColor = color.CGColor;\
view.layer.masksToBounds = YES;



// ============================== 刘海屏 ============================== //
#define IS_LiuHai_Screen \
({BOOL IS_LiuHai_Screen = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = UIApplication.sharedApplication.windows.firstObject;\
IS_LiuHai_Screen = window.safeAreaInsets.bottom > 0.0;\
}\
(IS_LiuHai_Screen);})

#define kHeightStatusBar                    (IS_LiuHai_Screen ?  44.0 : 20.0)
#define kHeightNavigationBar                (IS_LiuHai_Screen ?  88.0 : 64.0)
#define kHeightTabbar                       (IS_LiuHai_Screen ?  83.0 : 49.0)
#define kHeightBottomSafe                   (IS_LiuHai_Screen ?  34.0 : 0)



// ============================== font ============================== //
#define kScreenScale                        (kScreenWidth / 375.0)
#define kFont(font)                         [UIFont systemFontOfSize:font]
#define kScaleFont(font)                    [UIFont systemFontOfSize:(font * kScreenScale)]
#define kBaseFont                           [UIFont systemFontOfSize:14 * kScreenScale]
#define kFontBold(font)                     [UIFont boldSystemFontOfSize:(font * kScreenScale)]



// ============================== color ============================== //
#define kClearColor                         [UIColor clearColor]
#define kRedColor                           [UIColor redColor]
#define kWhiteColor                         [UIColor whiteColor]
#define kBlackColor                         [UIColor blackColor]
#define kGreenColor                         [UIColor greenColor]
#define kYellowColor                        [UIColor yellowColor]
#define kBlueColor                          [UIColor blueColor]
#define kGrayColor                          [UIColor grayColor]
#define kLightGrayColor                     [UIColor lightGrayColor]
#define kRGBColor(r, g, b)                  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define kRGBColorWithAlpha(r, g, b, a)      [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define kHomochromyColor(color)             kRGBColor(color, color, color)
#define kControllerBgColor                  kRGBColor(245, 245, 245)
#define kTintColor                          kRGBColor(221, 178, 109)
// 随机色
#define kRandomColor                        kRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



// ============================== image ============================== //
#define kImageNamed(imageNamed)             [UIImage imageNamed:imageNamed]

#endif /* AppMarco_UIKit_h */
