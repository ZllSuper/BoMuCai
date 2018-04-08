//
//  NSMutableDictionary+BXHMutableDictionary.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/15.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (BXHMutableDictionary)

- (void)safeSetStrObject:(id)object withKey:(NSString *)key;

@end
