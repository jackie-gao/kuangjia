//
//  ZXKJCommentModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/8.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCommentModel : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,strong) NSArray *images;




@property(nonatomic,assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
