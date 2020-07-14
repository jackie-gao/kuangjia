//
//  UIView+Empty.h
//  LSEmptyView
//
//  Created by larson on 2019/8/23.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSEmptyView;

@interface UIView (Empty)
/** 空页面占位图控件*/
@property(nonatomic,strong) LSEmptyView *emptyView;



// 使用下面的四个方法将emptyView的autoEmptyView设置为NO，关闭自动显隐，以保证不受自动显隐的影响

/**
 一般用于开始请求网络时调用，调用时会暂时隐藏emptyView
 当调用ls_endLoading方法时，ls_endLoading方法内部会根据当前的tableView/collectionView的DataSource来自动判断是否显示emptyView
 */
- (void)ls_startLoading;

/**
 在想要刷新empty状态时调用
 注意：ls_endLoading的调用时机，有刷新UI的地方一定要等到刷新UI的方法之后调用
 因为只有刷新了UI，view的DataSource才会更新，故调用次方法才能正确判断是否有内容
 */
- (void)ls_endLoading;


// 调用下面两个手动显隐的方法，不受dataSource的影响，单独设置显示与隐藏（前提是关闭autoShowEmptyView）
/** 手动调用显示emptyView*/
- (void)ls_showEmptyView;

/** 手动调用显示emptyView*/
- (void)ls_hideEmptyView;

@end
