//
//  NSDictionary+BXHMyDictionary.h
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-11-12.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BXHMyDictionary)

- (NSString *)jsonString;

- (id)safeObjectForKey:(id)key;

- (id)safeStrObjectForKey:(id)key;

- (NSString *)httpBody;

@end
