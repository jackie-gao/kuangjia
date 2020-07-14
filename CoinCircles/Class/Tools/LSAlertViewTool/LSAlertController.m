//
//  SSJDAlertController.m
//  shanShuiHotel
//
//  Created by larson on 2018/12/28.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

#import "LSAlertController.h"
#import "UILabel+LSAlertActionFont.h"

@interface LSAlertController ()

@end

@implementation LSAlertController

static UITextField *nicknameTF_ = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - <中间弹出的选择样式>
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title message:(NSString *)message fromVC:(UIViewController *)fromVC completeBlock:(void (^)(NSString *))completion
{
    LSAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancelAction setValue:kRGBColor(102, 102, 102) forKey:@"titleTextColor"];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 将数据传递出去
        !completion ? : completion(nicknameTF_.text);
    }];
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    
    [fromVC presentViewController:alertVc animated:YES completion:nil];
}



#pragma mark - <自定义的中间弹出样式>
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont message:(NSString *)message messageColor:(UIColor *)messageColor messageFont:(UIFont *)messageFont leftActionText:(NSString *)leftActionText leftActionColor:(UIColor *)leftActionColor rightActionText:(NSString *)rightActionText rightActionColor:(UIColor *)rightActionColor actionFont:(UIFont *)actionFont fromVC:(UIViewController *)fromVC leftActionHandleBlock:(void (^)(void))leftActionHandleBlock rightActionHandleBlock:(void (^)(void))rightActionHandleBlock
{
    LSAlertController *alertVC = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (title != nil) {
        // titleAttr
        NSMutableAttributedString *titleAttrStr = [[NSMutableAttributedString alloc] initWithString:title];
        [titleAttrStr addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, title.length)];
        [titleAttrStr addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, title.length)];
        [alertVC setValue:titleAttrStr forKey:@"attributedTitle"];
    }
    // messageAttr
    NSMutableAttributedString *messageAttrStr = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAttrStr addAttribute:NSForegroundColorAttributeName value:messageColor range:NSMakeRange(0, message.length)];
    [messageAttrStr addAttribute:NSFontAttributeName value:messageFont range:NSMakeRange(0, message.length)];
    [alertVC setValue:messageAttrStr forKey:@"attributedMessage"];
    // action
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftActionText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !leftActionHandleBlock ? : leftActionHandleBlock();
    }];
    [leftAction setValue:leftActionColor forKey:@"_titleTextColor"];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightActionText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !rightActionHandleBlock ? : rightActionHandleBlock();
    }];
    [rightAction setValue:rightActionColor forKey:@"_titleTextColor"];
    [alertVC addAction:leftAction];
    [alertVC addAction:rightAction];
    
    [fromVC presentViewController:alertVC animated:YES completion:nil];
}



#pragma mark - <带输入框的中间弹框样式>
+ (void)AlertStyleAndTextFieldWithTitle:(NSString *)title message:(NSString *)message textPlaechodle:(NSString *)placehodle fromVC:(UIViewController *)fromVC completeBlock:(void(^)(NSString *inputValue))completion;
{
    LSAlertController *alertVc = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:kRGBColor(51, 51, 51) range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertVc setValue:alertControllerStr forKey:@"attributedTitle"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancelAction setValue:kRGBColor(102, 102, 102) forKey:@"titleTextColor"];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 将数据传递出去
        !completion ? : completion(nicknameTF_.text);
    }];
    [sureAction setValue:kRGBColor(3, 207, 184) forKey:@"titleTextColor"];
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placehodle;
    }];
    
    // 放到确定按钮内部会造成循环引用的问题
    nicknameTF_ = alertVc.textFields.firstObject;
    
    [fromVC presentViewController:alertVc animated:YES completion:nil];
}




#pragma mark - <选择性别>
+ (void)selectSexWithTextColor:(UIColor *)color font:(UIFont *)font fromVC:(UIViewController *)fromVC completeBlock:(void(^)(NSString *sex))completion
{
    LSAlertController *alertVC= [self alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *menAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !completion ? : completion(action.title);
    }];
    [menAction setValue:color forKey:@"titleTextColor"];
    [alertVC addAction:menAction];
    
    UIAlertAction *womenAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !completion ? : completion(action.title);
    }];
    [womenAction setValue:color forKey:@"titleTextColor"];
    [alertVC addAction:womenAction];
    
    UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancleAlert setValue:color forKey:@"titleTextColor"];
    [alertVC addAction:cancleAlert];
    
    [fromVC presentViewController:alertVC animated:YES completion:nil];
}



#pragma mark - <提示用户打开权限>
+ (void)alertUserToOpenPermissions:(NSString *)text
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:text preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:text];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:kRGBColor(51, 51, 51) range:NSMakeRange(0, text.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, text.length)];
    [alertVC setValue:alertControllerStr forKey:@"attributedMessage"];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [kKeyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}



- (void)dealloc
{
    if (!nicknameTF_) return;
    [nicknameTF_ removeFromSuperview];
    nicknameTF_ = nil;
}


@end
