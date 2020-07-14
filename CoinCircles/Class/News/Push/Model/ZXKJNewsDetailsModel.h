//
//  ZXKJNewsDetailsModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/10.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJNewsDetailsModel : NSObject
@property(nonatomic,copy) NSString *imageNamed;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *time;

@property(nonatomic,assign) CGFloat cellHeight;

+ (instancetype)modelWithImageNamed:(NSString *)imageNamed
                           nickname:(NSString *)nickname
                               time:(NSString *)time
                            content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
