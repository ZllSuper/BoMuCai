//
//  NSArray+BXHArray.h
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-11-21.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BXHArray)

- (BOOL)strComperContationFromStr:(NSString *)str;

- (NSString *)jsonString;

- (id)safeObejectAtIndex:(NSInteger)index;

@end
