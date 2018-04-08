//
//  NSArray+BXHArray.m
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-11-21.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "NSArray+BXHArray.h"

@implementation NSArray (BXHArray)

- (id)safeObejectAtIndex:(NSInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (BOOL)strComperContationFromStr:(NSString *)str
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%@ CONTAINS[cd] SELF",str];
    NSArray *resultAry = [self filteredArrayUsingPredicate:pred];
    return resultAry.count > 0;
}

- (NSString *)jsonString
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
