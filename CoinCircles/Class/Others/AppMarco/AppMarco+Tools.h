//
//  AppMarco+Tools.h
//  CoinCircles
//
//  Created by Larson on 2020/7/1.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#ifndef AppMarco_Tools_h
#define AppMarco_Tools_h

// ============================== 环境部署 ============================== //
#ifdef DEBUG        // 调试阶段

#define LSLog(...) NSLog(__VA_ARGS__)
#define SSJDBaseURL           SSJDServiceURL

#else               // 开发阶段

#define LSLog(...)
#define SSJDBaseURL           SSJDServiceProURL

#endif



// ============================== 计算相对的值 ============================== //
#define kRelativityWidth(width)                         ((kScreenWidth * width ) / 375.0)
#define kRelativityHeight(height)                       ((kScreenWidth * height) / 375.0)
#define kRelativitySize(w, h)                           CGSizeMake(kRelativityWidth(w), kRelativityHeight(h))



// ============================== 弱引用 ============================== //
#define kWeakSelf(object)                               __weak __typeof(object) weak##_##object = object
#define kStrongSelf(object)                             __strong __typeof(object) object = weak##_##object



// ============================== GCD ============================== //
// 一次性执行
#define kDispatch_once_block(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
// 主线程执行
#define kDispatch_main_thread(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// 异步线程
#define kDispatch_global_queue_default(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
// 定时器
#define kDispatch_after(duration, afterBlock) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), afterBlock);

#endif /* AppMarco_Tools_h */
