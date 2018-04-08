//
//  NSDate+BXHMyDate.h
//  MessageList
//
//  Created by 步晓虎 on 14-9-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSTimeInterval const kTimeIntervalAnHour;
extern NSTimeInterval const kTimeIntervalADay;
extern NSTimeInterval const kTimeIntervalAMinute;

@interface NSDate (BXHMyDate)
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

/**
 * 返回当前的日期时间为午夜
 */
+ (NSDate*)dateWithToday;

/**
 * 返回同样的日期时间为午夜
 */
- (NSDate*)dateAtMidnight;

/**
 *  获取日
 */
- (NSInteger)getDay;

/**
 *  获取年
 */
- (NSInteger)getYear;

/**
 *  获取月
 */
- (NSInteger)getMonth;

/**
 *  获取时
 */
- (NSInteger)getHour;

/**
 *  获取分
 */
- (NSInteger)getMinute;

/**
 *  获取秒
 */
- (NSInteger)getSecond;

/**
 *  获取星期
 */
- (NSInteger)getWeekDay;

/**
 *  将utcDtae转成本地date
 *
 *  @param utcDate utcDate
 *
 *  @return 本地date
 */
+ (NSDate *)convertLocalDateFromUTCDate:(NSDate *)utcDate;

/**
 *  将本地Date转成UtcDate
 *
 *  @param localDate 本地Date
 *
 *  @return UtcDate
 */
+ (NSDate *)convertUTCDateFromLocalDate:(NSDate *)localDate;
/**
 *  从1900年开始了多少秒后的日期
 *
 *  @param secs 秒数
 *
 *  @return date
 */
+ (id)dateWithTimeIntervalSince1900:(NSTimeInterval)secs;

/**
 *  两个日期之间相差的年数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 天数
 */
+ (NSInteger)yearsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/**
 *  两个日期之间相差的月数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 天数
 */
+ (NSInteger)monthsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/**
 *  两个日期之间相差的天数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 天数
 */
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/**
 *  两个日期之间相差的分钟
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 分钟
 */
+ (NSInteger)minutesBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/**
 *  两个日期之间相差的秒数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 秒数
 */
+ (NSInteger)secondsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/*------------------format----------------------------------*/
/**
 *  将dateStr转成date
 *
 *  @param dateString   datestr
 *  @param formatString dateStr的Format
 *
 *  @return date
 */
+ (NSDate *)dateWithString:(NSString *)dateString inFormat:(NSString *)formatString;

/**
 *  将dateStr转成Str
 *
 *  @param dateString   datestr
 *  @param fromFormatStr dateStr的Format
 *  @param toFormatStr  返回str的Format
 *
 *  @return str
 */
+ (NSString *)dateWithString:(NSString *)dateStr fromFormat:(NSString *)fromFormatStr toFormat:(NSString *)toFormatStr;
/**
 *  返回现在距DateTime的相差分钟
 *
 *  @param dateTime 日期
 *
 *  @return 分钟
 */
+ (NSInteger)minutesFromNowToDate:(NSDate*)dateTime;

// date and time
+ (NSString*)dateDescriptionWithMediumStyle;

+ (NSString*)dateDescriptionFromFormat:(NSString*)format Date:(NSDate*)date;

/**
 *  yyyy-MM-dd HH:mm:ss
 */
- (NSString *)dateStrFormdefaultForamt;

/**
 *  根据format转成str
 *
 */
- (NSString *)dateStrWithFormatStr:(NSString *)format;

/**
 *
 *把Date根据Format转成str
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;

+ (NSString *)stringFormTime:(NSTimeInterval)time withFormate:(NSString *)string;

+ (NSTimeInterval)timeSince1970Date:(NSString *)dateStr withFormate:(NSString *)formate;

/**
 *转成UtcStr
 */
- (NSString *)utcString;

- (NSDate *)beginningOfWeek;

- (NSDate *)beginningOfDay;

- (NSDate *)endOfWeek;

+ (NSDate *)endOfToday;

+ (NSDate *)getInternetDate;

@end
