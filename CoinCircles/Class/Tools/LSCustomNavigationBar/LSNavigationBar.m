//
//  LSNavigationBar.m
//
//  Created by larson on 2019/1/5.
//  Copyright © 2019年 larosn. All rights reserved.
//

#import "LSNavigationBar.h"
#import <objc/runtime.h>

@implementation LSNavigationBar

#pragma mark - <LSNavigationBar>
+ (BOOL)isLiuHaiScreen
{
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        
        return safeAreaInsets.top == 44 || safeAreaInsets.bottom == 44 || safeAreaInsets.left == 44 || safeAreaInsets.right == 44;
    }else {
        return NO;
    }
}

// 导航栏底部的高度
+ (CGFloat)navigationBarBottom
{
    return [self isLiuHaiScreen] ? 88 : 64;
}

// tabBar的高度
+ (CGFloat)tabBarHeight
{
    return [self isLiuHaiScreen] ? 83 : 49;
}

// 屏幕的高度
+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

// 屏幕的高度
+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end





#pragma mark - <LSNavigationBar (LSDefault)>
@implementation LSNavigationBar (LSDefault)

static char kLSIsLocalUsedKey;
static char kLSWhiteistKey;      // 白名单的key
static char kLSBlackListKey;     // 黑名单的key

static char kLSDefaultNavigationBarBarTintColorKey;
static char kLSDefaultNavigationBarBackgroundImageKey;
static char kLSDefaultNavigationBarTintColorKey;
static char kLSDefaultNavigationBarTitleColorKey;
static char kLSDefaultStatusBarStyleKey;
static char kLSDefaultNavigationBarShadowImageHiddenKey;

// 作用暂时未知
+ (BOOL)isLocalUsed
{
    id isLocal = objc_getAssociatedObject(self, &kLSIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)LS_local
{
    objc_setAssociatedObject(self, &kLSIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// 作用暂时未知
+ (void)LS_widely
{
    objc_setAssociatedObject(self, &kLSIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置需要用到的控制器(有待完善)
+ (NSArray<NSString *> *)LS_whiteList
{
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kLSWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)LS_setWhiteList:(NSArray<NSString *> *)whiteList
{
    objc_setAssociatedObject(self, &kLSWhiteistKey, whiteList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 需要屏蔽的控制器
+ (NSArray<NSString *> *)blackList
{
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kLSBlackListKey);
    return (list != nil) ? list : nil;
}
// list不能设置为nil
+ (void)LS_setBlackList:(NSArray<NSString *> *)list
{
    objc_setAssociatedObject(self, &kLSBlackListKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 是否需要更新导航栏
+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc
{
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        // 当白名单里有，表示需要更新
        return [[self LS_whiteList] containsObject:vcStr];
    }else {
        // 当黑名单里没有，表示需要更新
        return ![[self blackList] containsObject:vcStr];
    }
}


#pragma mark - <导航栏的一些默认设置>
// 默认的导航栏的barTintColor
+ (UIColor *)defaultNavigationBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kLSDefaultNavigationBarBarTintColorKey);
    return (color != nil) ? color : UIColor.whiteColor;
}
+ (void)LS_setDefaultNavigationBarBarTintColor:(UIColor *)barTintColor
{
    objc_setAssociatedObject(self, &kLSDefaultNavigationBarBarTintColorKey, barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置默认导航栏的backgroundImage
+ (UIImage *)defaultNavigationBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kLSDefaultNavigationBarBackgroundImageKey);
    return image;
}
+ (void)LS_setDefaltNavigationBarBackgroundImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &kLSDefaultNavigationBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置默认的导航栏的tintColor
+ (UIColor *)defaultNavigationBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kLSDefaultNavigationBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1];
}
+ (void)LS_setDefaultNavigationBarTintColor:(UIColor *)tintColor
{
    objc_setAssociatedObject(self, &kLSDefaultNavigationBarTintColorKey, tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 导航栏的字体颜色
+ (UIColor *)defaultNavigationBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kLSDefaultNavigationBarTitleColorKey);
    return (color != nil) ? color : UIColor.blackColor;
}
+ (void)LS_setDefaultNavigationBarTitleColor:(UIColor *)titleColor
{
    objc_setAssociatedObject(self, &kLSDefaultNavigationBarTitleColorKey, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 状态栏的样式
+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kLSDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)LS_setDefaultStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kLSDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 是否隐藏ShadowImage
+ (BOOL)defaultNavigationBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kLSDefaultNavigationBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)LS_setDefaultNavigationBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kLSDefaultNavigationBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 导航栏默认的的alpha值
+ (CGFloat)defaultnavigationBarBackgroundAlpha
{
    return 1.0;
}

// 获取新的颜色
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    // 获取上一个控制器的颜色数据
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromeBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromeBlue alpha:&fromAlpha];
    
    // 获取下一个控制器的颜色数据
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    // 新颜色
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromeBlue + (toBlue - fromeBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}
// 获取新的透明度
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent
{
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end





#pragma mark - <UINavigationBar (LSAddition)>
@implementation UINavigationBar (LSAddition)

static char LSBackgroundViewKey;
static char LSBackgroundImageViewKey;
static char LSBackgroundImageKey;

#pragma mark <backgroundView>
- (UIView *)backgroundView
{
    return (UIView *)objc_getAssociatedObject(self, &LSBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView
{
    // 键盘处理
    if (backgroundView) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LS_keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LS_keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    objc_setAssociatedObject(self, &LSBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark <backgroundImageView>
- (UIImageView *)backgroundImageView
{
    return (UIImageView *)objc_getAssociatedObject(self, &LSBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)backgroundImageView
{
    objc_setAssociatedObject(self, &LSBackgroundImageViewKey, backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark <backgroundImage>
- (UIImage *)backgroundImage
{
    return (UIImage *)objc_getAssociatedObject(self, &LSBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    objc_setAssociatedObject(self, &LSBackgroundImageKey, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置导航栏的背景图
- (void)LS_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundView == nil) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc]initWithFrame:kRect(0, 0, CGRectGetWidth(self.bounds), [LSNavigationBar navigationBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            // 必须插入到最前面
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// 设置导航栏的barTintColor
- (void)LS_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc]initWithFrame:kRect(0, 0, CGRectGetWidth(self.bounds), [LSNavigationBar navigationBarBottom])];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// 键盘处理
- (void)LS_keyboardDidShow
{
    [self LS_restoreUIBarBackgroundFrame];
}
- (void)LS_keyboardWillHide
{
    [self LS_restoreUIBarBackgroundFrame];
}
// 恢复bar的位置
- (void)LS_restoreUIBarBackgroundFrame
{
    for (UIView *view in self.subviews) {
        Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
        if (_UIBarBackgroundClass != nil) {
            if ([view isKindOfClass:_UIBarBackgroundClass]) {
                view.frame = kRect(0, self.bounds.size.height - [LSNavigationBar navigationBarBottom], [LSNavigationBar screenWidth], [LSNavigationBar navigationBarBottom]);
            }
        }
    }
}

// 设置导航栏的alpha
- (void)LS_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *)) {
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    }else {
        barBackgroundView.alpha = alpha;
    }
}

// 设置导航栏上的item的alpha
- (void)LS_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES) {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 如果这里不做判断会显示backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 导航栏在垂直方向上的平移的距离
- (void)LS_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)LS_getTranslationY
{
    return (CGFloat)self.transform.ty;
}


#pragma mark - <runtime主动交换方法>
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
        
        for (NSInteger i = 0; i < 1; i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"LS_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

// 设置title的富文本属性
- (void)LS_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *, id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *, id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self LS_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self LS_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self LS_setTitleTextAttributes:newTitleTextAttributes];
}

@end





#pragma mark - <UIViewController (LSExtension)>
@interface UIViewController (Addition)

- (void)setPushToCurrentVCFinished:(BOOL)isFinished;

@end





#pragma mark - <UINavigationBar (LSAddition)>
@implementation UINavigationController (LSExtension)

#pragma mark <pop/push的progress>
// pop的progress
static CGFloat LSPopDuration = 0.12;
static int LSPopDisplayCount = 0;
- (CGFloat)LS_popProgress
{
    CGFloat all = LSPopDuration * 60;
    int current = MIN(all, LSPopDisplayCount);
    
    return current / all;
}

// push的progress
static CGFloat LSPushDuration = 0.1;
static int LSPushDisplayCount = 0;
- (CGFloat)LS_pushProgress
{
    CGFloat all = LSPushDuration * 60;
    int current = MIN(all, LSPushDisplayCount);
    
    return current / all;
}


#pragma mark <首选的statusBarStyle>
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController LS_statusBarStyle];
}


#pragma mark <导航栏需要更新的属性>
- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage
{
    [self.navigationBar LS_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)batTintColor
{
    [self.navigationBar LS_setBackgroundColor:batTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha
{
    [self.navigationBar LS_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor
{
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden
{
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : titleColor};
        return;
    }
    
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

#pragma mark <更新控制器的pop和push>
- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    // 改变导航栏的BarTintColor
    UIColor *fromBarTintColor = [fromVC LS_navigationBarBarTintColor];
    UIColor *toBarTintColor = [toVC LS_navigationBarBarTintColor];
    UIColor *newBarTintColor = [LSNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([LSNavigationBar needUpdateNavigationBar:fromVC] || [LSNavigationBar needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // 改变导航栏的tintColor
    UIColor *fromTintColor = [fromVC LS_navigationBarTintColor];
    UIColor *toTintColor = [toVC LS_navigationBarTintColor];
    UIColor *newTintColor = [LSNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([LSNavigationBar needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }
    
    // 改变导航栏的titleColor
    UIColor *fromTitleColor = [fromVC LS_navigationBarTitleColor];
    UIColor *toTitleColor = [toVC LS_navigationBarTitleColor];
    UIColor *newTitleColor = [LSNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    // 在该方法中直接改变标题的颜色
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // 改变的导航栏的alpha
    CGFloat fromBarBackgroundAlpha = [fromVC LS_navigationBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC LS_navigationBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [LSNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}


#pragma mark <call swizzling methods active 主动调用交换方法>
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
        
        for (int i = 0; i < 4; i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"LS_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMeyhod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMeyhod);
        }
    });
}


#pragma mark <pop控制器>
- (NSArray<UIViewController *> *)LS_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // pop的时候直接改变 barTintColor和tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController LS_navigationBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController LS_navigationBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        LSPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:LSPopDuration];
    [CATransaction begin];
    
    NSArray<UIViewController *> *vcs = [self LS_popToViewController:viewController animated:animated];
    [CATransaction commit];
    
    return vcs;
}

// pop到根控制器
- (NSArray<UIViewController *> *)LS_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        LSPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:LSPopDuration];
    [CATransaction begin];
    
    NSArray<UIViewController *> *vcs = [self LS_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    
    return vcs;
}

// 是否需要显示pop
- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        LSPopDisplayCount += 1;
        CGFloat popProgress = [self LS_popProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}


#pragma mark <push控制器>
- (void)LS_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        LSPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:LSPushDuration];
    [CATransaction begin];
    [self LS_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// 更改navigationBar barTintColor平滑之前推到当前VC完成或弹出到当前VC完成
- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        LSPushDisplayCount += 1;
        CGFloat pushProgress = [self LS_pushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

// 返回姿态
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof(self) kWeakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    __strong typeof(self) pThis = kWeakSelf;
                    [pThis dealInteractionChanges: context];
                }];
            } else {
                if (@available(iOS 10.0, *)) {
                    [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                        __strong typeof(self) pThis = kWeakSelf;
                        [pThis dealInteractionChanges:context];
                    }];
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}
// 返回姿态
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void(^animations)(UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key) {
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc LS_navigationBarBarTintColor];
        CGFloat curAlpha = [vc LS_navigationBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // 取消返回的手势
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }else {
        
        // 完成返回的手势
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)LS_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self LS_updateInteractiveTransition:percentComplete];
}

@end





#pragma mark - <UIViewController(LSExtension)>
@implementation UIViewController (LSExtension)

static char kLSPushToCurrentVCFinishedKey;
static char kLSPushToNextVCFinishedKey;
static char kLSNavigationBarBackgroundImageKey;
static char kLSNavigationBarBarTintColorKey;
static char kLSNavigationBarBackgroundAlphaKey;
static char kLSNavigationBarTintColorKey;
static char kLSNavigationBarTitleColorKey;
static char kLSStatusBarStyleKey;
static char kLSNavigationBarShadowImageHiddenKey;
static char kLSCustomNavigationBarKey;
static char kLSSystemNavigationBarBarTintColorKey;
static char kLSSystemNavigationBarTintColorKey;
static char kLSSystemNavigationBarTitleColorKey;

// 从fromVC推送到currentVC之前，barTintColor是否能被改变
- (BOOL)pushToCurrentVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kLSPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kLSPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 从currentVC推送到nextVC之前，barTintColor是否能被改变
- (BOOL)pushToNextVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kLSPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kLSPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarBackgroundImage
- (UIImage *)LS_navigstionBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kLSNavigationBarBackgroundImageKey);
    image = (image == nil) ? [LSNavigationBar defaultNavigationBarBackgroundImage] : image;
    
    return image;
}
- (void)LS_setNavigationBarBackgroundImage:(UIImage *)image
{
    if ([[self LS_customNavigationBar] isKindOfClass:[UINavigationBar class]]) {
//        UINavigationBar *navBar = (UINavigationBar *)[self LS_customNavigationBar];
//        [navBar LS_setBackgroundImage:image];
    }else {
        objc_setAssociatedObject(self, &kLSNavigationBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


#pragma mark <barTintColor>
// navigationBar systemBarTintColor
- (UIColor *)LS_systemNavigationBarBarTintColor
{
    return (UIColor *)objc_getAssociatedObject(self, &kLSSystemNavigationBarBarTintColorKey);
}
- (void)LS_setSystemNavigationBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kLSSystemNavigationBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor
- (UIColor *)LS_navigationBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kLSNavigationBarBarTintColorKey);
    if (![LSNavigationBar needUpdateNavigationBar:self]) {
        if ([self LS_systemNavigationBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        }else {
            barTintColor = [self LS_systemNavigationBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [LSNavigationBar defaultNavigationBarBarTintColor];
}
- (void)LS_setNavigationBarBarTintColor:(UIColor *)barTintColor
{
    objc_setAssociatedObject(self, &kLSNavigationBarBarTintColorKey, barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self LS_customNavigationBar] isKindOfClass:[UINavigationBar class]]) {
//        UINavigationBar *narBar = (UINavigationBar *)[self LS_customNavigationBar];
//        [narBar LS_setBackgroundColor:barTintColor];
    }else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:barTintColor];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)LS_navigationBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kLSNavigationBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [LSNavigationBar defaultnavigationBarBackgroundAlpha];
}
- (void)LS_setNavigationBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kLSNavigationBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self LS_customNavigationBar] isKindOfClass:[UINavigationBar class]]) {
//        UINavigationBar *navBar = (UINavigationBar *)[self LS_customNavigationBar];
//        [navBar LS_setBackgroundAlpha:alpha];
    }else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}


#pragma mark <tintColor>
// navigationBar systemTintColor
- (UIColor *)LS_systemNavigationBarTintColor
{
    return (UIColor *)objc_getAssociatedObject(self, &kLSSystemNavigationBarTintColorKey);
}
- (void)LS_setSystemNavigationBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kLSSystemNavigationBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)LS_navigationBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kLSNavigationBarTintColorKey);
    if (![LSNavigationBar needUpdateNavigationBar:self]) {
        if ([self LS_systemNavigationBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        }else {
            tintColor = [self LS_systemNavigationBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [LSNavigationBar defaultNavigationBarTintColor];
}
- (void)LS_setNavigationBarTintColor:(UIColor *)tintColor
{
    objc_setAssociatedObject(self, &kLSNavigationBarTintColorKey, tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self LS_customNavigationBar] isKindOfClass:[UINavigationBar class]]) {
//        UINavigationBar *navBar = (UINavigationBar *)[self LS_customNavigationBar];
//        navBar.tintColor = tintColor;
    }else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:tintColor];
        }
    }
}


#pragma mark <titleColor>
// systemTitleColor
- (UIColor *)LS_systemNavigationBarTitleColor
{
    return (UIColor *)objc_getAssociatedObject(self, &kLSSystemNavigationBarTitleColorKey);
}
- (void)LS_setSystemNavigationBatTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kLSSystemNavigationBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// titleColor
- (UIColor *)LS_navigationBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kLSNavigationBarTitleColorKey);
    if (![LSNavigationBar needUpdateNavigationBar:self]) {
        if ([self LS_systemNavigationBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        }else {
            titleColor = [self LS_systemNavigationBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [LSNavigationBar defaultNavigationBarTitleColor];
}
- (void)LS_setNavigationBarTitleColor:(UIColor *)titleColor
{
    objc_setAssociatedObject(self, &kLSNavigationBarTitleColorKey, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self LS_customNavigationBar] isKindOfClass:[UINavigationBar class]]) {
//        UINavigationBar *navBar = (UINavigationBar *)[self LS_customNavigationBar];
//        navBar.titleTextAttributes = @{NSForegroundColorAttributeName : titleColor};
    }else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:titleColor];
        }
    }
}


#pragma mark <statusBarStyle>
- (UIStatusBarStyle)LS_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kLSStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [LSNavigationBar defaultStatusBarStyle];
}
- (void)LS_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kLSStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark <shadowImage>
- (BOOL)LS_navigationShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kLSNavigationBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [LSNavigationBar defaultNavigationBarShadowImageHidden];
}
- (void)LS_setNavigationBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kLSNavigationBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}


#pragma mark <custom navigationBar>
- (UIView *)LS_customNavigationBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kLSCustomNavigationBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)LS_setCustomNavigationBar:(UINavigationBar *)navigationBar
{
    objc_setAssociatedObject(self, &kLSCustomNavigationBarKey, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark <交换方法>
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        
        for (int i = 0; i < 4; i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"LS_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}


#pragma mark - <自定义初始化方法>
- (void)LS_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar]) {
        if (![LSNavigationBar needUpdateNavigationBar:self]) {
            if ([self LS_systemNavigationBarBarTintColor] == nil) {
                [self LS_setSystemNavigationBarBarTintColor:[self LS_navigationBarBarTintColor]];
            }
            if ([self LS_systemNavigationBarTintColor] == nil) {
                [self LS_setSystemNavigationBarTintColor:[self LS_systemNavigationBarTintColor]];
            }
            if ([self LS_systemNavigationBarTitleColor] == nil) {
                [self LS_setSystemNavigationBatTitleColor:[self LS_systemNavigationBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self LS_navigationBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self LS_navigationBarTitleColor]];
    }
    [self LS_viewWillAppear:animated];
}

- (void)LS_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self LS_viewWillDisappear:animated];
}

- (void)LS_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES) {
        UIImage *barBackgroundImage = [self LS_navigstionBarBackgroundImage];
        if (barBackgroundImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBackgroundImage];
        }else {
            if ([LSNavigationBar needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self LS_navigationBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self LS_navigationBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self LS_navigationBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self LS_navigationBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self LS_navigationShadowImageHidden]];
    }
    [self LS_viewDidAppear:animated];
}

- (void)LS_viewDidDisappear:(BOOL)animated
{
    if (![LSNavigationBar needUpdateNavigationBar:self] && !self.navigationController) {
        [self LS_setSystemNavigationBarBarTintColor:nil];
        [self LS_setSystemNavigationBarTintColor:nil];
        [self LS_setSystemNavigationBatTitleColor:nil];
    }
    [self LS_viewDidDisappear:animated];
}


// 是否更新导航栏
- (BOOL)canUpdateNavigationBar
{
    return [self.navigationController.viewControllers containsObject:self];
}

// 是否是根控制器
- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    }else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}

@end
