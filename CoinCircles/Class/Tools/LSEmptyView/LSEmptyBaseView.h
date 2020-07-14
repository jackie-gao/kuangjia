//
//  LSEmptyBaseView.h
//  LSEmptyView
//
//  Created by larson on 2019/4/16.
//  Copyright © 2019年 qingYunHotelInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

// 事件回调
typedef void(^LSActionTapBlock)(void);

@interface LSEmptyBaseView : UIView
// 属性传值(可修改)
/** image的优先级大于 imageStr，只有一个有效*/
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,copy) NSString *imageString;
@property(nonatomic,copy) NSString *titleString;
@property(nonatomic,copy) NSString *detailString;
@property(nonatomic,copy) NSString *buttonTitleString;

// 属性传递(只读)
@property(nonatomic,strong,readonly) UIView *contentView;
@property(nonatomic,weak,readonly) id actionButtonTarget;
@property(nonatomic,assign,readonly) SEL actionButtonAction;
@property(nonatomic,copy,readonly) LSActionTapBlock buttonActionBlock;
@property(nonatomic,strong,readonly) UIView *customView;

/** emptyView内容区域点击事件*/
@property(nonatomic,copy) LSActionTapBlock tapContentViewBlock;



/** 初始化配置*/
- (void)prepare;

/** 重置subviews*/
- (void)setupSubviews;



// 构建方法
/**
 * 创建emptyView
 *
 * @param image                   占位图片
 * @param titleString             标题
 * @param detailString            详细描述
 * @param buttonTitleString       按钮的名称
 * @param target                  响应的对象
 * @param action                  按钮点击事件
 *
 * @return                        实例化的emptyView
 */
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString
                       buttonTitleString:(NSString *)buttonTitleString
                                  target:(id)target
                                  action:(SEL)action;

/**
 * 创建emptyView
 *
 * @param image                   占位图片
 * @param titleString             标题
 * @param detailString            详细描述
 * @param buttonTitleString       按钮的名称
 * @param buttonActionBlock       按钮点击事件回调
 *
 * @return                        实例化的emptyView
 */
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString
                       buttonTitleString:(NSString *)buttonTitleString
                       buttonActionBlock:(LSActionTapBlock)buttonActionBlock;

/**
 * 创建emptyView
 *
 * @param imageString             占位图片名称
 * @param titleString             标题
 * @param detailString            详细描述
 * @param buttonTitleString       按钮的名称
 * @param target                  响应的对象
 * @param action                  按钮点击事件
 *
 * @return                        实例化的emptyView
 */
+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString
                             buttonTitleString:(NSString *)buttonTitleString
                                        target:(id)target
                                        action:(SEL)action;

/**
 * 创建emptyView
 *
 * @param imageString             占位图片名称
 * @param titleString             标题
 * @param detailString            详细描述
 * @param buttonTitleString       按钮的名称
 * @param buttonActionBlock       按钮点击事件回调
 *
 * @return                        实例化的emptyView
 */
+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString
                             buttonTitleString:(NSString *)buttonTitleString
                             buttonActionBlock:(LSActionTapBlock)buttonActionBlock;

/**
 * 创建emptyView
 *
 * @param image                   占位图片
 * @param titleString             标题
 * @param detailString            详细描述
 *
 * @return                        实例化一个没有按钮点击事件的emptyView
 */
+ (instancetype)emptyActionViewWithImage:(UIImage *)image
                             titleString:(NSString *)titleString
                            detailString:(NSString *)detailString;

/**
 * 创建emptyView
 *
 * @param imageString             占位图片名称
 * @param titleString             标题
 * @param detailString            详细描述
 *
 * @return                        创建好的emptyView
 */
+ (instancetype)emptyActionViewWithImageString:(NSString *)imageString
                                   titleString:(NSString *)titleString
                                  detailString:(NSString *)detailString;

/**
 * 创建一个自定义的emptyView
 *
 * @param customView              自定义的customView
 *
 * @return                        创建好的emptyView
 */
+ (instancetype)emptyViewWithCustomView:(UIView *)customView;

@end
