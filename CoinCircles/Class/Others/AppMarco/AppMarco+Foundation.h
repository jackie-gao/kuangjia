//
//  AppMarco+Foundation.h
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#ifndef AppMarco_Foundation_h
#define AppMarco_Foundation_h

// ============================== null to nil ============================== //
#define OPTSafetyObj(obj)                   ((NSNull *)(obj) == [NSNull null] ? nil : (obj))
#define kCheckNull(__X__)                   ((__X__) == [NSNull null] || ([(__X__) isKindOfClass:[NSString class]] && [(__X__) isEqualToString:@""])) ? nil : (__X__)



// ============================== string ============================== //
#define kString(text)                        [NSString stringWithFormat:@"%@", text == nil ? @"" : text]
#define kStringOfInt(text)                   [NSString stringWithFormat:@"%d", text];
#define kStringOfInteger(text)               [NSString stringWithFormat:@"%ld", (long)text]
#define kStringOfFloat(text)                 [NSString stringWithFormat:@"%f", text]
#define kStringOfMoneyFloat(text)            [NSString stringWithFormat:@"%.2f", text]
#define kStringOfBool(text)                  (text) ? @"1" : @"0"



// ============================== url ============================== //
#define kUrl(string)                         [NSURL URLWithString:(string ? string : @"")]

#endif /* AppMarco_Foundation_h */
