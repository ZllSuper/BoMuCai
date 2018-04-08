//
//  NSDate+BXHMyDate.m
//  MessageList
//
//  Created by 步晓虎 on 14-9-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "NSDate+BXHMyDate.h"
#import "NSString+BXHMyString.h"

typedef  enum {

    DateType_Year = 1,
    DateType_Month,
    DateType_Day,
    DateType_Hour,
    DateType_Minute,
    DateType_Second,
    DateType_Week,
    
}DateType;

@implementation NSDate (BXHMyDate)
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    
    return [dateComps date];
}
/**
 * 返回当前的日期时间为午夜
 */
+ (NSDate*)dateWithToday
{
    return [[NSDate date] dateAtMidnight];
}

/**
 * 返回同样的日期时间为午夜
 */
- (NSDate*)dateAtMidnight
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:
                               (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)
                                           fromDate:[NSDate date]];
	NSDate *midnight = [gregorian dateFromComponents:comps];
	return midnight;
}

/**
 *  获取天
 */
- (NSInteger)getDay
{
   return [self getDateCalendarUnitWithDateType:DateType_Day];
}

/**
 *  获取年
 */
- (NSInteger)getYear
{
    return [self getDateCalendarUnitWithDateType:DateType_Year];
}

/**
 *  获取月
 */
- (NSInteger)getMonth
{
    return [self getDateCalendarUnitWithDateType:DateType_Month];
}

/**
 *  获取时
 */
- (NSInteger)getHour
{
    return [self getDateCalendarUnitWithDateType:DateType_Hour];
}

/**
 *  获取分
 */
- (NSInteger)getMinute
{
    return [self getDateCalendarUnitWithDateType:DateType_Minute];
}

/**
 *  获取秒
 */
- (NSInteger)getSecond
{
    return [self getDateCalendarUnitWithDateType:DateType_Second];
}

/**
 *  获取星期
 */
- (NSInteger)getWeekDay
{
    return [self getDateCalendarUnitWithDateType:DateType_Week];
}

- (NSInteger)getDateCalendarUnitWithDateType:(DateType)dateType
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    
    switch (dateType)
    {
        case DateType_Year:
            return [comps year];
            break;
        case DateType_Month:
            return [comps month];
            break;
        case DateType_Day:
            return [comps day];
            break;
        case DateType_Hour:
            return [comps hour];
            break;
        case DateType_Minute:
            return [comps minute];
            break;
        case DateType_Second:
            return [comps second];
            break;
        case DateType_Week:
            return [comps weekday];
            break;
        default:
            return 0;
            break;
    }
}

+ (NSDate *)convertLocalDateFromUTCDate:(NSDate *)utcDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:utcDate];
    NSDate *retDate = [utcDate  dateByAddingTimeInterval:interval];
    return retDate;
}


+ (NSDate *)convertUTCDateFromLocalDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* strDate = [dateFormatter stringFromDate:localDate];
    
    // Modify by Arthur
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* retDate = [outputFormatter dateFromString:strDate];
    return retDate;
}



+ (id)dateWithTimeIntervalSince1900:(NSTimeInterval)secs
{
    NSDate *ret = nil;
    NSTimeInterval dateSec = secs - 2208960000;
    ret = [NSDate dateWithTimeIntervalSince1970:dateSec];
    return ret;
}

/**
 *  两个日期之间相差的年数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 天数
 */
+ (NSInteger)yearsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSYearCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    
    return [difference year];
}

/**
 *  两个日期之间相差的月数
 *
 *  @param fromDateTime 开始日期
 *  @param toDateTime   结束日期
 *
 *  @return 天数
 */
+ (NSInteger)monthsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSMonthCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    
    return [difference month];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    
    return [difference day];
}


+ (NSInteger)minutesBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSMinuteCalendarUnit
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    [calendar rangeOfUnit:NSMinuteCalendarUnit
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSMinuteCalendarUnit
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference minute];
}


+ (NSInteger)minutesFromNowToDate:(NSDate*)dateTime
{
    NSDate *date = [NSDate date];
    return [NSDate minutesBetweenDate:dateTime andDate:date];
}


+ (NSInteger)secondsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSSecondCalendarUnit
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    [calendar rangeOfUnit:NSSecondCalendarUnit
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSSecondCalendarUnit
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference second];
}

#pragma format
+ (NSDate *)dateWithString:(NSString *)dateString inFormat:(NSString *)formatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatString];
    return [formatter dateFromString:dateString];
}

+ (NSString *)dateWithString:(NSString *)dateStr fromFormat:(NSString *)fromFormatStr toFormat:(NSString *)toFormatStr{
    if ([NSString stringIsEmpty:dateStr]) return @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromFormatStr];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:toFormatStr];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:string];
    return [formatter stringFromDate:date];
}

+ (NSString*)dateDescriptionWithMediumStyle
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSDate *date = [NSDate date];
	return [dateFormatter stringFromDate:date];
}


+ (NSString*)dateDescriptionFromFormat:(NSString *)format Date:(NSDate*)date
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
	[dateFormatter setTimeZone:timeZone];
	return [dateFormatter stringFromDate:date];
}

- (NSString *)dateStrFormdefaultForamt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)stringFormTime:(NSTimeInterval)time withFormate:(NSString *)string
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:time];
    return [startDate dateStrWithFormatStr:string];
}

+ (NSTimeInterval)timeSince1970Date:(NSString *)dateStr withFormate:(NSString *)formate
{
    NSDate *date = [NSDate dateWithString:dateStr inFormat:formate];
    return date.timeIntervalSince1970;
}

/**
 *  根据format转成str
 *
 */
- (NSString *)dateStrWithFormatStr:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)utcString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
	NSString *timestamp_str = [formatter stringFromDate:self];
	return timestamp_str;
}

- (NSDate *)beginningOfWeek
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
	BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate:self];
	if (ok)
    {
		return beginningOfWeek;
	}
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
	
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
	[componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
	
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:beginningOfWeek];
	return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:self];
	return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	[componentsToAdd setDay:(7 - [weekdayComponents weekday])];
	NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	return endOfWeek;
}

+ (NSDate *)endOfToday
{
    NSString* strDate = [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"];
    NSString* strEndToday = [NSString stringWithFormat:@"%@ 23:59:59", strDate];
    return [NSDate dateWithString:strEndToday inFormat:@"yyyy-MM-dd HH:mm:ss"];
}

/**
 
 *  获取网络当前时间
 
 */

+ (NSDate *)getInternetDate

{
    
    NSString *urlString = @"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json";
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    // 实例化NSMutableURLRequest，并进行参数配置
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString: urlString]];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [request setTimeoutInterval: 3];
    
    [request setHTTPShouldHandleCookies:FALSE];
    
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *response;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
     
                          returningResponse:&response error:nil];
    
    
    
    // 处理返回的数据
    
    //    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    if (data == nil || data.length <= 0)
    {
        return nil;
    }
    
    NSLog(@"response is %@",response);
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [jsonStr jsonObject];
    NSString *successCode = dict[@"success"];
    if ([successCode integerValue] != 1)
    {
        return nil;
    }
    NSDictionary *resultDict = dict[@"result"];
    
    NSString *date = [resultDict objectForKey:@"datetime_1"];
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    
    [dMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *netDate = [dMatter dateFromString:date];
    
    return netDate;
    
}

@end
