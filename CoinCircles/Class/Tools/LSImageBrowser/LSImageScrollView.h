//
//  LSImageScrollView.h
//  LSImageBrowser
//
//  Created by larson on 2019/5/3.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSImageItem, LSProgressShapeLayer;

/// 进度block
typedef void(^LSProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL);
// 完成block
typedef void(^LSCompletedBlock)(UIImage *image, NSURL *imageURL);

@interface LSImageScrollView : UIScrollView
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) LSImageItem *imageItem;
@property(nonatomic,strong) LSProgressShapeLayer *progressLayer;
@property(nonatomic,copy) LSProgressBlock progressBlock;
@property(nonatomic,copy) LSCompletedBlock compleedBlock;



/** 取消当前加载的图片的请求*/
- (void)cancelCurrentImageLoading;

@end
