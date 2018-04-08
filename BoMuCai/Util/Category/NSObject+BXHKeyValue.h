//
//  NSObject+BXHKeyValue.h
//  BXHKeyValue
//
//  Created by 步晓虎 on 16/3/24.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BXHKeyValueProtcol <NSObject>


@optional
//替换propertyName取值
- (NSDictionary *)bxhReplaceKeyFormPropertyNames;

//不允许的propertyName取值
- (NSArray *)bxhIgnoredPropertyNames;

//用于转化model中还有model的情况
- (void)keyValueToObjecDidFinish;

//用于转化model中还有model的情况
- (void)objectToKeyValueWillBegain;

@end

@interface NSObject (BXHKeyValue) <BXHKeyValueProtcol>

- (instancetype)bxhObjectWithKeyValues:(id)keyValues;

+ (instancetype)bxhObjectWithKeyValues:(id)keyValues;

+ (NSMutableArray *)bxhObjectArrayWithKeyValuesArray:(id)keyValuesAry;

- (NSMutableDictionary *)bxhkeyValues;

+ (NSMutableArray *)bxhKeyValuesArrayWithObjectAry:(NSArray *)objectAry;

- (NSString *)toJson;

- (instancetype)bxhCopy;

@end
