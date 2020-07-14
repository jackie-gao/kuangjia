//
//  AppDelegate.m
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "AppDelegate.h"
#import "LSGuideTool.h"
#import "JhtGuidePages_SDK/JhtGuidePages.framework/Headers/JhtGradientGuidePageVC.h"
@interface AppDelegate ()
/** 引导页VC */
@property (nonatomic, strong) JhtGradientGuidePageVC *introductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建引导页
//    [self createGuideVC];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
              self.window.rootViewController = [LSGuideTool chooseRootViewController];
              [self.window makeKeyAndVisible];
              
              // IQKeyboard键盘设置
              [LSKeyboardTool setupKeyboard];
    
    return YES;
}

/** 创建引导页 */
- (void)createGuideVC {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstKey = [NSString stringWithFormat:@"isFirst%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    NSString *isFirst = [defaults objectForKey:firstKey];
    
    NSMutableArray *backgroundImageNames = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *coverImageNames = [NSMutableArray arrayWithCapacity:4];
    if (!isFirst.length) {
        for (NSInteger i = 1; i < 2; i ++) {
            NSString *temp1 = [NSString stringWithFormat:@"ggps_%ld_bg", i];
            NSString *temp2 = [NSString stringWithFormat:@"ggps_%ld_text", i];
            if ([[UIApplication sharedApplication] statusBarFrame].size.height > 20) {
                temp1 = [NSString stringWithFormat:@"x_%@", temp1];
                temp2 = [NSString stringWithFormat:@"x_%@", temp2];
            }
            
            [backgroundImageNames addObject:temp1];
            [coverImageNames addObject:temp2];
        }
        
        // case 1
        UIButton *enterButton = [[UIButton alloc] init];
        [enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
        [enterButton setBackgroundColor:[UIColor purpleColor]];
        enterButton.layer.cornerRadius = 8.0;
 
        self.introductionView = [[JhtGradientGuidePageVC alloc] initWithCoverImageNames:coverImageNames withBackgroundImageNames:backgroundImageNames withEnterButton:enterButton withLastRootViewController:[LSGuideTool chooseRootViewController]];
        
        // 添加《跳过》按钮
        self.introductionView.isNeedSkipButton = YES;
        /******** 更多个性化配置见《JhtGradientGuidePageVC.h》 ********/
        
        self.window.rootViewController = self.introductionView;
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didClickedEnter = ^() {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *firstKey = [NSString stringWithFormat:@"isFirst%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            NSString *isFirst = [defaults objectForKey:firstKey];
            if (!isFirst) {
                [defaults setObject:@"notFirst" forKey:firstKey];
                [defaults synchronize];
            }
            
            weakSelf.introductionView = nil;
        };
        
    } else {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
           self.window.rootViewController = [LSGuideTool chooseRootViewController];
           [self.window makeKeyAndVisible];
           
           // IQKeyboard键盘设置
           [LSKeyboardTool setupKeyboard];
//        self.window.rootViewController = [[ViewController alloc] init];
    }
}


@end
