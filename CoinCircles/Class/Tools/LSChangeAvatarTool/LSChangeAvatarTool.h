//
//  LSChangeAvatar.h
//  larson
//
//  Created by larson on 2016/11/1.
//  Copyright © 2016年 larson. All rights reserved.
//

// ----- 更换头像的工具类 ----- //
// 该工具类需要被强引用，才能正常使用

#import <Foundation/Foundation.h>

@interface LSChangeAvatarTool : NSObject

/**
 * 换头像处理，以及更换头像成功之后的操作
 @param containerVC 容器控制器
 @param completion 上传图片成功之后的操作
 */
- (void)changeAvatarWithContainerVC:(UIViewController *)containerVC
                         completion:(void(^)(UIImage *))completion;

/**
 * 选择图片
 *
 * @param containerVC                        容器控制器
 * @param completion                          选择图片成功之后的回调
 */
- (void)selectImageWithContainerVC:(UIViewController *)containerVC
                        completion:(void(^)(UIImage *image))completion;

@end
