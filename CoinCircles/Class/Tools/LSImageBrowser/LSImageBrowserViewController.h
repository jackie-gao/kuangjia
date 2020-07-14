//
//  LSImageBrowserViewController.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSImageBrowserHeader.h"
#import "LSImageItem.h"

@interface LSImageBrowserViewController : UIViewController
/** 指示器的样式，默认为圆点样式，大于9张图片，显示文本样式*/
@property(nonatomic,assign) LSBrowserpageStyle pageStyle;



/**
 *  初始化图片浏览器
 *
 *  @imageItems     图片的模型
 *  @selectIndex    选择的下标
 *
 *  @return         图片浏览器
 */
+ (instancetype)browserWithImageItems:(NSArray<LSImageItem *>*)imageItems
                        selectedIndex:(NSInteger)selectIndex;
/**
 *  初始化图片浏览器
 *
 *  @imageItems     图片的模型
 *  @selectIndex    选择的下标
 *
 *  @return         图片浏览器
 */
- (instancetype)initWithImageItems:(NSArray<LSImageItem *>*)imageItems
                     selectedIndex:(NSInteger)selectedIndex;
/** 显示图片浏览器*/
- (void)showImageBrowser;

@end
