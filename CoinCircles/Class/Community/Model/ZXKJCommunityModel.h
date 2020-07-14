//
//  ZXKJCommunityModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCommunityModel : NSObject
/** title*/
@property(nonatomic,copy) NSString *title;
/** contentText*/
@property(nonatomic,copy) NSString *content;
/** 图片*/
@property(nonatomic,strong) NSArray *images;
/** time*/
@property(nonatomic,strong) NSString *time;


/** 文字的高度*/
@property(nonatomic,assign) CGFloat textHeight;
/** 图片的高度*/
@property(nonatomic,assign) CGFloat imageHeight;
/** 行高*/
@property(nonatomic,assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
