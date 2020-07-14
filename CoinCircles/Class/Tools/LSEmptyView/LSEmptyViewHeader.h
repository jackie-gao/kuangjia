//
//  LSEmptyViewHeader.h
//  LSEmptyView
//
//  Created by larson on 2019/8/22.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

// ======================= 空视图的占位视图 ======================= //

#ifndef LSEmptyViewHeader_h
#define LSEmptyViewHeader_h

// 每个子控件之间的间距
#define kEmptyViewSubviewMargin             20.f
// 描述字体大小
#define kEmptyViewTitleLabelFont            [UIFont systemFontOfSize:16.f]
// 详情描述字体大小
#define kEmptyViewDetailsLabelFont          [UIFont systemFontOfSize:14.f]
// 按钮字体大小
#define kEmptyViewButtonFont                [UIFont systemFontOfSize:14.f]
// 按钮高度
#define kEmptyViewButtonHeight              40.f
// 水平方向内边距
#define kEmptyViewButtonHorizontalMargin    30.f

//背景色
#define kEmptyViewBackgroundColor           [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1]
#define kEmptyViewBlackColor                [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]
#define kEmptyViewGrayColor                 [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.f]
#define kEmptyViewRGBA(r,g,b,a)             [UIColor colorWithRed:r green:g blue:b alpha:a]



#import "LSEmptyView.h"
#import "UIView+Empty.h"
#import "UIView+Frame.h"

#endif
