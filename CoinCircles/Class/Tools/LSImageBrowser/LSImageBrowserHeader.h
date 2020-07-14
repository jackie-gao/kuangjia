//
//  LSImageBrowserHeader.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

// https://github.com/MrDML/DMLPhotoBrowser

#ifndef LSImageBrowserHeader_h
#define LSImageBrowserHeader_h

/** 指示器的样式*/
typedef enum : NSUInteger {
    LSImageBrowserpageStyleDot,      // 圆点样式
    LSImageBrowserpageStyleText,     // 文本样式
} LSBrowserpageStyle;



#define kImageBrowserWidth              UIScreen.mainScreen.bounds.size.width
#define kImageBrowserHeight             UIScreen.mainScreen.bounds.size.height
#define kImageBrowserScreenBounds       UIScreen.mainScreen.bounds

// iOS11
#define kImageBrowseriOS11 UIDevice.currentDevice.systemVersion.floatValue

#define kImageBrowserCollectionMargin   20


#endif
