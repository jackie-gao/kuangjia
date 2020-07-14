//
//  WeakScriptMessageDelegate.h
//  shanShuiHotel
//
//  Created by larson on 2019/6/18.
//  Copyright © 2019 qingYunHotelInfo. All rights reserved.
//

// ---------- 解决<WKScriptMessageHandler>不能释放的问题 ---------- //

#import <WebKit/WebKit.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
@property(nonatomic,weak) id<WKScriptMessageHandler> scriptDelegate;


- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
