//
//  NSMutableDictionary+BXHMutableDictionary.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/15.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "NSMutableDictionary+BXHMutableDictionary.h"

@implementation NSMutableDictionary (BXHMutableDictionary)

- (void)safeSetStrObject:(id)object withKey:(NSString *)key
{
    if ([NSString stringIsEmpty:object])
    {
        return;
    }
    [self setObject:object forKey:key];
}

@end
