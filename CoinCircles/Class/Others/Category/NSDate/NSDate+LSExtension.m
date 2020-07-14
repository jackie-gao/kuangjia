//
//  NSDate+LSExtension.m
//
//  Created by larson on 2016/1/4.
//  Copyright © 2016年 larson. All rights reserved.
//

#import "NSDate+LSExtension.h"

@implementation NSDate (LSExtension)

#pragma mark - <是否为今年>
- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 当前的年份
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    // 调用对象的年份
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}


#pragma mark - <是否为今天>
- (BOOL)isToday
{
    // 时间格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 当前时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}


#pragma mark - <是否为昨天>
- (BOOL)isYesterdat
{
    // 2017-12-31 23:59:59 -> 2017-12-31
    // 2018-01-01 00:00:01 -> 2018-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 当前时间的字符串
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}



#pragma mark - <日历>
/// 时间容器
- (NSDateComponents *)ls_components
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    
    return dateComponents;
}

/// 当前月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth
{
    NSRange daysInMonth = [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return daysInMonth.length;
}

/// 当前月有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekDay = [[self firstDayOfCurrentMonth]weeklyOrdinality];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    if (weekDay > 1) {
        weeks += 1;
        days -= (7 - weeks + 1);
    }
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

/// 计算当前月的第一天是星期几
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekday forDate:self];
}

/** 计算这个月开始的第一天*/
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    
    return startDate;
}

/// 当前月的最后一天
- (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

/// 上一个月
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/// 下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/// 获取当前月份之后的几个月
- (NSDate *)dayInTheFollowingMonth:(NSInteger)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = month;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/// 当前日期之后的几天
- (NSDate *)dayInTheFollowingDay:(NSInteger)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.day = day;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

/// NSString转NSDate
- (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz"
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
}

/// NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

/// 暂时未知
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    // 日历
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    NSInteger day = [dateComponents day];
    
    return day;
}

/// 未知
- (NSInteger)getWeekIntValueWithDate
{
    NSInteger weekInValue;
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:self];
    
    return weekInValue = [dateComponents weekday];
}


/// 判断日期是今天，明天，后天，周几
- (NSString *)compareIfTodayWithDate
{
    NSDate *todate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *componentsToday = [calendar components:calendarUnit fromDate:todate];
    NSDateComponents *componentsOtherDay = [calendar components:calendarUnit fromDate:self];
    
    // 获取星期对应的数字
    NSInteger weekInValue = [self getWeekIntValueWithDate];
    if (componentsToday.year == componentsOtherDay.year &&
        componentsToday.month == componentsOtherDay.month &&
        componentsToday.day == componentsOtherDay.day) {
        return @"今天";
    }
    else if (componentsToday.year == componentsOtherDay.year &&
             componentsToday.month == componentsOtherDay.month &&
             (componentsToday.day - componentsOtherDay.day) == -1)
    {
        return @"明天";
    }
    else if (componentsToday.year == componentsOtherDay.year &&
             componentsToday.month == componentsOtherDay.month &&
             (componentsToday.day - componentsOtherDay.day) == -2)
    {
        return @"后天";
    }
    else
    {
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekInValue];
    }
}



#pragma mark - <获取当前的时间>
+ (NSString *)getCurrentTimesWithTimeType:(NSString *)timetype
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:timetype];
    NSDate *currentDate = [NSDate date];
    
    return [formatter stringFromDate:currentDate];
}


#pragma mark - <获取明天的时间>
+ (NSString *)getTomorrowDayWithTimeType:(NSString *)timeType
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compoents = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    [compoents setDay:[compoents day] + 1];
    
    NSDate *beginWeek = [gregorian dateFromComponents:compoents];
    NSDateFormatter *dateDay = [[NSDateFormatter alloc]init];
    [dateDay setDateFormat:timeType];
    
    return [dateDay stringFromDate:beginWeek];
}


#pragma mark - <时间差值>
- (NSDateComponents *)deltaForm:(NSDate *)formDate
{
    // 获取日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:formDate toDate:self options:0];
}



#pragma mark - <方法>
/// 通过数字返回星期几
+ (NSString *)getWeekStringFromInteger:(NSInteger)week
{
    NSString *weekString;
    switch (week) {
        case 1:
            weekString = @"周日";
            break;
            
        case 2:
            weekString = @"周一";
            break;
            
        case 3:
            weekString = @"周二";
            break;
            
        case 4:
            weekString = @"周三";
            break;
            
        case 5:
            weekString = @"周四";
            break;
            
        case 6:
            weekString = @"周五";
            break;
            
        case 7:
            weekString = @"周六";
            break;
            
        default:
            break;
    }
    return weekString;
}




#pragma mark - <获取时间的年月日>
- (NSString *)getYTDTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:self];
}



#pragma mark - <获取时间的月份和日期>
- (NSString *)getMonthAndDay
{
    // 月
    NSDateFormatter *MonthFormatter = [[NSDateFormatter alloc]init];
    [MonthFormatter setDateFormat:@"MM"];
    NSInteger month = [[MonthFormatter stringFromDate:self] integerValue];
    // 日
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    [dayFormatter setDateFormat:@"dd"];
    NSInteger day = [[dayFormatter stringFromDate:self] integerValue];
    
    return [NSString stringWithFormat:@"%zd月%zd日", month, day];
}


#pragma mark - <根据日期获取星期>
- (NSString *)weekdayString
{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/BeiJing"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

/// 计算两个时间之间的差值
- (NSInteger)timeDeltaForm:(NSDate *)formDate
{
    // 比较时间
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 获取日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:formDate toDate:self options:0];
    
//    return dateComponents.day;
    return ABS(dateComponents.day);
}





#pragma mark - <获取当前的时间(年月日时分秒)>
+ (NSString *)getCurrentTimes
{
    return [NSDate getCurrentTimesWithTimeType:@"yyyy-MM-dd HH:mm:ss"];
}


// 获取明天的时间
+ (NSDate *)getTomorrowDate
{
    NSDateComponents *dayComponents = [[NSDateComponents alloc]init];
    dayComponents.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateByAddingComponents:dayComponents toDate:[NSDate date] options:0];
    
    return nextDate;
}

@end





