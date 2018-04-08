//
//  NSDictionary+BXHMyDictionary.m
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-11-12.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "NSDictionary+BXHMyDictionary.h"

@implementation NSDictionary (BXHMyDictionary)

- (NSString *)jsonString
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)safeObjectForKey:(id)key
{
    if ([self.allKeys containsObject:key])
    {
        return [self objectForKey:key];
    }
    return @"";
}

- (id)safeStrObjectForKey:(id)key
{
    if ([self.allKeys containsObject:key])
    {
        if (![NSString stringIsEmpty:self[key]])
        {
            return self[key];
        }
    }
    return @"";
}


- (NSString *)httpBody
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString *key in self.keyEnumerator)
    {
        NSString *value = self[key];
        NSString *pair = [NSString stringWithFormat:@"%@=%@",key,value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    return params;
}



@end
