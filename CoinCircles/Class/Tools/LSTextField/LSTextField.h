//
//  LSTextField.h
//
//  Created by larson on 2016/12/29.
//  Copyright © 2016年 larson. All rights reserved.
//

// ----- 修改textField的占位文字的颜色 ----- //

#import <UIKit/UIKit.h>

@interface LSTextField : UITextField

/** 修改占位文字颜色*/
@property(nonatomic,strong) UIColor *placeholderColor;

@end
