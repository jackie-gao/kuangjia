//
//  ZXKJCommunityDetailsModel.h
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXKJCommunityDetailsModel : NSObject
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *time;

+ (instancetype)modelWithUsername:(NSString *)username content:(NSString *)content time:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
