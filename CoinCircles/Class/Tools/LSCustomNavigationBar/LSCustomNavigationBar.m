//
//  LSCustomNavigationBar.m
//  2.自定义导航栏
//
//  Created by larson on 2018/12/31.
//  Copyright © 2018年 larosn. All rights reserved.
//

#import "LSCustomNavigationBar.h"
#import "sys/utsname.h"

#define LSDefaultTitleSize 18
#define LSDefaultRightButtonTitleSize 14
#define LSRightButtonDefaultColor kRGBColor(51, 51, 51)
#define LSDefaultTitleColor [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
#define LSDefaultBackgroundColor [UIColor whiteColor]
#define LSScreenWidth [UIScreen mainScreen].bounds.size.width
#define LSBottonLineHeight 0.5


// viewController的分类
@implementation UIViewController(LSRoute)

// 最后一个控制器
- (void)LS_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentationController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (self.presentationController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


// 当前的控制器
+ (UIViewController *)LS_currentViewController
{
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    UIViewController *rootViewController = window.rootViewController;
    
    return [self LS_currentViewControllerFrom:rootViewController];
}


+ (UIViewController *)LS_currentViewControllerFrom:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)viewController;
        return [self LS_currentViewControllerFrom:navVC.viewControllers.lastObject];
    }
    else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)viewController;
        return [self LS_currentViewControllerFrom:tabBarVC.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self LS_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end



@interface LSCustomNavigationBar ()
@property(nonatomic,strong) UIButton    *leftButton;
@property(nonatomic,strong) UILabel     *titleLabel;
@property(nonatomic,strong) UIButton    *rightButton;
@property(nonatomic,strong) UIView      *bottomLine;
@property(nonatomic,strong) UIView      *backgroundView;
@property(nonatomic,strong) UIImageView *backgroundImageView;

@end

@implementation LSCustomNavigationBar

#pragma mark - <初始化>
+ (instancetype)customNavigationBar
{
    LSCustomNavigationBar *navigationBar = [[self alloc]initWithFrame:kRect(0, 0, LSScreenWidth, [LSCustomNavigationBar getNavBarHeight])];
    return navigationBar;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightButton];
    [self addSubview:self.bottomLine];
    [self updateFrame];
    self.backgroundColor = UIColor.clearColor;
    self.backgroundView.backgroundColor = LSDefaultBackgroundColor;
}



#pragma mark - <更新frame>
- (void)updateFrame
{
    NSInteger top = [LSCustomNavigationBar isLiuHaiScreen] ? 44 : 20;
    NSInteger leftMargin = 0;
    NSInteger rightMargin = 11;
    NSInteger buttonHeight = 44;
    NSInteger leftButtonWidth = 44;
    NSInteger rightButtonWidth = 70;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = 180;
    
    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    self.leftButton.frame = kRect(leftMargin, top, leftButtonWidth, buttonHeight);
    self.rightButton.frame = kRect(LSScreenWidth - rightButtonWidth - rightMargin, top, rightButtonWidth, buttonHeight);
    self.titleLabel.frame = kRect((LSScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = kRect(0, self.bounds.size.height - LSBottonLineHeight, LSScreenWidth, LSBottonLineHeight);
}



#pragma mark - <action>
// 左边按钮
- (void)clickBack
{
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    }else {
        UIViewController *currentVC = [UIViewController LS_currentViewController];
        [currentVC LS_toLastViewController];
    }
}

// 右边按钮
- (void)clickRight
{
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}



#pragma mark - <setter>
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = title;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    self.titleLabel.textColor = titleLabelColor;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    self.titleLabel.font = titleLabelFont;
}

- (void)setTitleLabelAlpha:(CGFloat)titleLabelAlpha
{
    _titleLabelAlpha = titleLabelAlpha;
    self.titleLabel.alpha = titleLabelAlpha;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor
{
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = barBackgroundColor;
}

- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage
{
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = barBackgroundImage;
}



#pragma mark - <接口调用>
- (void)LS_setBottomLineHidden:(BOOL)hidden
{
    self.bottomLine.hidden = hidden;
}

- (void)LS_setBackgroundAlpha:(CGFloat)alpha
{
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)LS_setTintColor:(UIColor *)color
{
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleLabel setTextColor:color];
}


// 左边按钮
- (void)LS_setLeftButtonWithNormal:(UIImage *)image highlighted:(UIImage *)highlightedImage title:(NSString *)title titleColor:(UIColor *)titleColor
{
    self.leftButton.hidden = NO;
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)LS_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self LS_setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}

- (void)LS_setLeftButtonWithNormalImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    [self LS_setLeftButtonWithNormal:image highlighted:highlightedImage title:nil titleColor:nil];
}

- (void)LS_setLeftButtonWithImage:(UIImage *)image
{
    [self LS_setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}

- (void)LS_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self LS_setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}


// 右边按钮
- (void)LS_setRightButtonWithNormal:(UIImage *)image highlighted:(UIImage *)highlightedImage title:(NSString *)title titleColor:(UIColor *)titleColor
{
    self.rightButton.hidden = NO;
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)LS_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self LS_setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}

- (void)LS_setRightButtonWithNormalImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    [self LS_setRightButtonWithNormal:image highlighted:highlightedImage title:nil titleColor:nil];
}

- (void)LS_setRightButtonWithImage:(UIImage *)image
{
    [self LS_setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}

- (void)LS_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor
{
    [self LS_setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}



#pragma mark - <懒加载>
- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.imageEdgeInsets = kEdgeInsets(0, 0, 0, 10);
        _leftButton.hidden = YES;
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = LSDefaultTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:LSDefaultTitleSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}


- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:LSDefaultRightButtonTitleSize];
        [_rightButton setTitleColor:LSRightButtonDefaultColor forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1];
    }
    return _bottomLine;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}





#pragma mark - <工具>
/** 获取导航栏的高度*/
+ (CGFloat)getNavBarHeight
{
    return 44 + [self getStatusBarHeight];
}

/** 是否是刘海屏*/
+ (BOOL)isLiuHaiScreen
{
    if (@available(iOS 11.0, *)) {
//        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
        
        return safeAreaInsets.top == 44 || safeAreaInsets.bottom == 44 || safeAreaInsets.left == 44 || safeAreaInsets.right == 44;
    }else {
        return NO;
    }
}

// 获取状态栏的高度
+ (CGFloat)getStatusBarHeight
{
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    return statusBarHeight;
}

@end
