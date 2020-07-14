//
//  NSDate+LSExtension.h
//
//  Created by larson on 2016/1/4.
//  Copyright © 2016年 larson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LSExtension)

/** 是否为今年*/
- (BOOL)isThisYear;

/** 是否为今天*/
- (BOOL)isToday;

/** 是否为昨天*/
- (BOOL)isYesterdat;


/// 日历
/** 时间容器*/
- (NSDateComponents *)ls_components;

/** 当前月有多少天*/
- (NSUInteger)numberOfDaysInCurrentMonth;

/** 当前月有多少周*/
- (NSUInteger)numberOfWeeksInCurrentMonth;

/** 当前月的第一天是星期几*/
- (NSUInteger)weeklyOrdinality;

/** 当前月的第一天*/
- (NSDate *)firstDayOfCurrentMonth;

/** 当前月的最后一天*/
- (NSDate *)lastDayOfCurrentMonth;

/** 上一个月*/
- (NSDate *)dayInThePreviousMonth;

/** 下一个月*/
- (NSDate *)dayInTheFollowingMonth;

/**
 *  当前月份之后的几个月
 *
 *  @param month        当前的月份
 *
 *  @return             时间数据
 */
- (NSDate *)dayInTheFollowingMonth:(NSInteger)month;

/**
 *  当前日期之后的几天
 *
 *  @param day          当前的日期
 *
 *  @return             时间数据
 */
- (NSDate *)dayInTheFollowingDay:(NSInteger)day;

/**
 *  NSString转NSDate
 *
 *  @param dateString   需要转换的时间string
 *
 *  @return             时间数据
 */
- (NSDate *)dateFromString:(NSString *)dateString;

/**
 *  NSDate转NSString
 *
 *  @param date         需要转换的date
 *
 *  @return             时间数据
 */
- (NSString *)stringFromDate:(NSDate *)date;

/**
 *  /////
 *
 *
 *  @return             时间数据
 */
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

/// 作用暂时未知
- (NSInteger)getWeekIntValueWithDate;


// 判断日期是今天，明天，后天，周几
- (NSString *)compareIfTodayWithDate;





/**
 *  获取当前的时间
 *
 *  @param timeType     需要的时间格式
 *
 *  @return             当期的时间
 */
+ (NSString *)getCurrentTimesWithTimeType:(NSString *)timeType;

/**
 *  获取明天的时间
 *
 *  @param timeType     需要的时间格式
 *
 *  @return             明天的时间
 */
+ (NSString *)getTomorrowDayWithTimeType:(NSString *)timeType;

/**
 *  计算时间差值
 *
 *  @param  formDate     从什么时间开始计算
 *
 *  @return              传入时间与当前时间之间的差值
 */
- (NSDateComponents *)deltaForm:(NSDate *)formDate;



/**
 *  获取时间的年月日
 *
 *  @return             年月日时间，使用 - 隔开
 */
- (NSString *)getYTDTime;

/**
 *  获取时间的月份和日期
 *
 *  @return             月份
 */
- (NSString *)getMonthAndDay;

/**
 *  根据日期获取星期
 *
 *  @return             星期
 */
- (NSString *)weekdayString;

/**
 *  计算两个时间之间的差值
 *
 *  @return             两个时间相差的天数
 */
- (NSInteger)timeDeltaForm:(NSDate *)formDate;



/**
 *  获取当前的时间(年月日时分秒)
 *
 *  @return             当前的时间字符串
 */
+ (NSString *)getCurrentTimes;


/** 获取明天的时间*/
+ (NSDate *)getTomorrowDate;

@end
