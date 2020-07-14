//
//  UILabel+LSAlertActionFont.h
//  shanShuiHotel
//
//  Created by larson on 2019/7/3.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

// --------------- 用来设置UIAlertAction的字体大小 --------------- //
// 修改所有出现在UIAlertController中字体的样式（这种方法不好的地方就是，所有的字体样式都改变了）

#import <UIKit/UIKit.h>

@interface UILabel (LSAlertActionFont)
@property (nonatomic,copy) UIFont *appearanceFont UI_APPEARANCE_SELECTOR;

@end
