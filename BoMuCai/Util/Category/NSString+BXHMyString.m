//
//  NSString+BXHMyString.m
//  TestMessage
//
//  Created by 步晓虎 on 14-9-4.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "NSString+BXHMyString.h"
#import "NSData+BXHMyData.h"

@implementation NSString (BXHMyString)

NSString * StringFilterNull(id orgStr)
{
    if ([orgStr isKindOfClass:[NSNull class]]) {
        return @"";
    }else if (orgStr == nil || orgStr == NULL) {
        return @"";
    }else if ([orgStr isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", orgStr];
    }else  {
        return [NSString stringWithFormat:@"%@", orgStr];
    }
    return @"";
}


- (NSString *)urlEncoded
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

- (NSString *)utf8ReplaceEncode
{
    
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)unicode
{
    const char *b = [self cStringUsingEncoding:NSUnicodeStringEncoding];
    return [[NSString alloc] initWithCString:b encoding:NSUnicodeStringEncoding];
}

- (NSString *)md5Hash
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}

- (NSString *)sha1Hash
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1Hash];
}

/**
 * 生成GUID
 */
+ (NSString *)generateUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}


- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd])
    {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2)
        {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            if (kvPair.count == 1)
            {
                [pairs setObject:[NSNull null] forKey:key];
                
            }
            else if (kvPair.count == 2)
            {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [pairs setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator])
    {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound)
    {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}

- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query
{
    NSMutableDictionary* encodedQuery = [NSMutableDictionary dictionaryWithCapacity:[query count]];
    
    for (NSString* key in [query keyEnumerator])
    {
        NSParameterAssert([key respondsToSelector:@selector(urlEncoded)]);
        NSString* value = [query objectForKey:key];
        NSParameterAssert([value respondsToSelector:@selector(urlEncoded)]);
        value = [value urlEncoded];
        NSString *urlEncodedKey = [key urlEncoded];
        [encodedQuery setValue:value forKey:urlEncodedKey];
    }
    
    return [self stringByAddingQueryDictionary:encodedQuery];
}

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str color:(UIColor *)color
{
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:self];
    [outStr addAttributes:@{NSForegroundColorAttributeName : Color_MainText} range:NSMakeRange(0, self.length)];
    [outStr addAttributes:@{NSForegroundColorAttributeName : color} range:range];
    return outStr;
}

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str targetColor:(UIColor *)color originalColor:(UIColor *)originalColor
{
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:self];
    [outStr addAttributes:@{NSForegroundColorAttributeName : originalColor} range:NSMakeRange(0, self.length)];
    [outStr addAttributes:@{NSForegroundColorAttributeName : color} range:range];
    return outStr;
}


- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str attribuDict:(NSDictionary *)dict
{
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:self];
    [outStr addAttributes:dict range:range];
    return outStr;
}

#pragma Font

- (CGSize) size_With_Font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version < 7.0)
    {
        return [self sizeWithFont: font];
    }
    else
    {
        return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
    }
#endif
}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size lineBreakMode: lineBreakMode];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
    
}

- (NSString *)stringByRemovingHTMLTags
{
    NSString *html = [self mutableCopy];
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+ (NSString *)checkNilStrWithStr:(NSString *)sourceStr
{
    if ([self stringIsEmpty:sourceStr])
    {
        return @"";
    }
    return sourceStr;
}

+ (BOOL)stringIsEmpty:(NSString *)sourceStr
{
    if (sourceStr && [sourceStr isKindOfClass:[NSString class]] && sourceStr.length > 0 && ![sourceStr isEqualToString:@"(null)"] && ![sourceStr isEqualToString:@"<null>"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSString *)checkNilStr
{
    if ([NSString stringIsEmpty:self])
    {
        return @"";
    }
    return self;
}

NSString * CheckString(NSString *str)
{
    if ([NSString stringIsEmpty:str])
    {
        return @"";
    }
    return str;
}

BOOL StringIsEmpty(NSString *str)
{
    return [NSString stringIsEmpty:str];
}

NSString * MoneyDeal(NSString *str)
{
    CGFloat money = [str floatValue] / 100;
    return _StrFormate(@"%.2lf",money);
}


- (id)jsonObject
{
    NSError *parseError = nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&parseError];
    return jsonObject;
    
}

- (NSString *)formatCardNumber
{
    NSNumber *number = @([self longLongValue]);
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "];
    return [formatter stringFromNumber:number];
}

- (NSArray *)rangesOfFindText:(NSString *)searchText
{
    NSMutableArray *arrayRanges = [NSMutableArray array];
    if (searchText == nil && [searchText isEqualToString:@""])
    {
        return nil;
    }
    NSRange rang = [self rangeOfString:searchText];
    if (rang.location != NSNotFound && rang.length != 0)
    {
        [arrayRanges addObject:NSStringFromRange(rang)];
        NSInteger location = rang.location + rang.length;
        NSInteger length = self.length - rang.location - rang.length;
        while (length > 0)
        {
            rang = NSMakeRange(location, length);
            rang = [self rangeOfString:searchText options:NSCaseInsensitiveSearch range:rang];
            if (rang.location == NSNotFound && rang.length == 0)
            {
                break;
            }
            else
            {
                [arrayRanges addObject:NSStringFromRange(rang)];
            }
            location = rang.location + rang.length;
            length = self.length - rang.location - rang.length;
        }
        return arrayRanges;
    }
    return nil;
}

@end
