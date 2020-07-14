//
//  LSPlaceholderTextView.h
//  larson
//
//  Created by larson on 2017/1/30.
//  Copyright © 2017年 larson. All rights reserved.
//

// ----- 拥有占位文字功能的textView ----- //

#import <UIKit/UIKit.h>

@interface LSPlaceholderTextView : UITextView

/** 占位文字*/
@property(nonatomic,copy) NSString *placeholder;
/** 占位文字颜色(必须要设置)*/
@property(nonatomic,strong) UIColor *placeholderColor;

@end
