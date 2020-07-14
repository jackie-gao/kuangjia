//
//  ZXKJFlashNewsModel.m
//  CoinCircles
//
//  Created by Larson on 2020/7/7.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "ZXKJFlashNewsModel.h"

@implementation ZXKJFlashNewsModel

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat textHeight = [self.content getTextHeightWithViewWidth:kScreenWidth - 50 textFont:kFont(14)];
        _cellHeight = textHeight + 40;
    }
    return _cellHeight;
}





+ (void)loadDataWithParams:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSShareNetworkingTool GET:ZCKJBaseURL parameters:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(id error) {
        failure(error);
    }];
}

@end
