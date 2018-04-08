//
//  NSObject+BXHKeyValue.m
//  BXHKeyValue
//
//  Created by 步晓虎 on 16/3/24.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "NSObject+BXHKeyValue.h"
#import <objc/runtime.h>

//NSString *const BXHPropertyTypeInt = @"i";
//NSString *const BXHPropertyTypeShort = @"s";
//NSString *const BXHPropertyTypeFloat = @"f";
//NSString *const BXHPropertyTypeDouble = @"d";
//NSString *const BXHPropertyTypeLong = @"l";
//NSString *const BXHPropertyTypeLongLong = @"q";
NSString *const BXHPropertyTypeBOOL1 = @"c";
NSString *const BXHPropertyTypeBOOL2 = @"b";


static NSArray * jsonClass()
{
    static NSArray *jsonClasses;
    if (jsonClasses == nil)
    {
        jsonClasses = [NSArray arrayWithObjects:[NSString class],[NSNumber class],[NSArray class],[NSDictionary class],[NSMutableArray class],[NSMutableDictionary class],nil];
    }
    return jsonClasses;
}

static BOOL validObjectClassIsJsonClass(Class c)
{
    NSArray *classAry = jsonClass();
    for (Class class in classAry)
    {
        if ([c isSubclassOfClass:class])
        {
            return YES;
        }
    }
    return NO;
}


@implementation NSObject (BXHKeyValue)

- (instancetype)bxhCopy
{
    Class class = [self class];
    id object = [[class alloc] init];
    
    NSArray *ignoredAry;
    NSDictionary *replaceDict;
    
    if ([self respondsToSelector:@selector(bxhIgnoredPropertyNames)])
    {
        ignoredAry = [self performSelector:@selector(bxhIgnoredPropertyNames)];
    }
    
    if ([self respondsToSelector:@selector(bxhReplaceKeyFormPropertyNames)])
    {
        replaceDict = [self performSelector:@selector(bxhReplaceKeyFormPropertyNames)];
    }

    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++ )
    {
        objc_property_t property = properties[i];
     
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *valueKey = propertyName;
        
        if ([ignoredAry containsObject:propertyName])
        {
            continue;
        }
        
        if ([[replaceDict allKeys] containsObject:propertyName])
        {
            valueKey = [replaceDict objectForKey:propertyName];
        }
        
        [object setValue:[self valueForKeyPath:valueKey] forKeyPath:valueKey];
    }
    free(properties);
    return object;
}

- (instancetype)bxhObjectWithKeyValues:(id)keyValues
{
    
    // 获得JSON对象
    NSAssert([keyValues isKindOfClass:[NSDictionary class]], @"keyValues参数不是一个字典");
    
    NSArray *ignoredAry;
    NSDictionary *replaceDict;
    
    if ([self respondsToSelector:@selector(bxhIgnoredPropertyNames)])
    {
        ignoredAry = [self performSelector:@selector(bxhIgnoredPropertyNames)];
    }
    
    if ([self respondsToSelector:@selector(bxhReplaceKeyFormPropertyNames)])
    {
        replaceDict = [self performSelector:@selector(bxhReplaceKeyFormPropertyNames)];
    }
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++ )
    {
        objc_property_t property = properties[i];
        NSString *attrs = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        // 2.成员类型
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) { // 没有,
            code = [attrs substringFromIndex:loc];
        } else {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        NSString *propertyClassName = [self propertyClassName:code];
        BOOL boolType = [self boolType:code];
        if (propertyClassName.length == 0 && boolType)
        {
            propertyClassName = [NSNumber className];
        }
        Class propertyClass = NSClassFromString(propertyClassName);
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *valueKey = propertyName;
        
        if ([ignoredAry containsObject:propertyName])
        {
            continue;
        }
        
        if ([[replaceDict allKeys] containsObject:propertyName])
        {
            valueKey = [replaceDict objectForKey:propertyName];
        }
        
        id value = [keyValues objectForKey:valueKey];
        if ([value isKindOfClass:[NSNull class]] || value == nil)
        {
            continue;
        }

        if (validObjectClassIsJsonClass(propertyClass))
        {
            // 不可变 -> 可变处理
            if (propertyClass == [NSMutableArray class] && [value isKindOfClass:[NSArray class]])
            {
                value = [NSMutableArray arrayWithArray:value];
            }
            else if (propertyClass == [NSMutableDictionary class] && [value isKindOfClass:[NSDictionary class]])
            {
                value = [NSMutableDictionary dictionaryWithDictionary:value];
            }
            else if (propertyClass == [NSMutableString class] && [value isKindOfClass:[NSString class]])
            {
                value = [NSMutableString stringWithString:value];
            }
        }
        else
        {
            value = [propertyClass bxhObjectWithKeyValues:value];
        }
        [self setValue:value forKey:propertyName];
    }
    
    if ([self respondsToSelector:@selector(keyValueToObjecDidFinish)])
    {
        [self keyValueToObjecDidFinish];
    }
    
    free(properties);
    return self;
}

+ (instancetype)bxhObjectWithKeyValues:(id)keyValues
{
    return [[[self alloc] init] bxhObjectWithKeyValues:keyValues];
}

+ (NSMutableArray *)bxhObjectArrayWithKeyValuesArray:(id)keyValuesAry;
{
    NSAssert([[keyValuesAry class] isSubclassOfClass:[NSArray class]], @"类型错误");
    
    NSMutableArray *objectsAry = [NSMutableArray array];
    
    for (int i = 0; i < [keyValuesAry count]; i++)
    {
        id object = [keyValuesAry objectAtIndex:i];
        NSAssert([[object class] isSubclassOfClass:[NSDictionary class]], @"子类型错误");
        [objectsAry addObject:[[self alloc] bxhObjectWithKeyValues:object]];
    }
    
    return objectsAry;
}

- (NSMutableDictionary *)bxhkeyValues
{
    if ([self respondsToSelector:@selector(objectToKeyValueWillBegain)])
    {
        [self objectToKeyValueWillBegain];
    }

    NSArray *ignoredAry;
    NSDictionary *replaceDict;
    if ([self respondsToSelector:@selector(bxhIgnoredPropertyNames)])
    {
        ignoredAry = [self performSelector:@selector(bxhIgnoredPropertyNames)];
    }
    
    if ([self respondsToSelector:@selector(bxhReplaceKeyFormPropertyNames)])
    {
        replaceDict = [self performSelector:@selector(bxhReplaceKeyFormPropertyNames)];
    }
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i ++ )
    {
        objc_property_t property = properties[i];
        NSString *attrs = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        // 2.成员类型
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound)
        { // 没有,
            code = [attrs substringFromIndex:loc];
        }
        else
        {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        NSString *propertyClassName = [self propertyClassName:code];
        BOOL boolType = [self boolType:code];
        if (propertyClassName.length == 0 && boolType)
        {
            propertyClassName = [NSNumber className];
        }
        Class propertyClass = NSClassFromString(propertyClassName);
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *valueKey = propertyName;
        
        if ([ignoredAry containsObject:propertyName])
        {
            continue;
        }
        
        if ([[replaceDict allKeys] containsObject:propertyName])
        {
            valueKey = [replaceDict objectForKey:propertyName];
        }
        
        
        id value = [self valueForKey:propertyName];
    
        if (!value)
        {
            if (!validObjectClassIsJsonClass(propertyClass))
            {
                value = @{};
            }
            else
            {
                value = @"";
            }
        }
        else
        {
            if (!validObjectClassIsJsonClass(propertyClass))
            {
                value = [value bxhkeyValues];
            }
        }
        [resultDict setObject:value forKey:valueKey];
    }
    free(properties);
    return resultDict;
}

+ (NSMutableArray *)bxhKeyValuesArrayWithObjectAry:(NSArray *)objectAry
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id object in objectAry)
    {
        if (validObjectClassIsJsonClass([object class]))
        {
            [resultArray addObject:object];
        }
        else
        {
            [resultArray addObject:[object bxhkeyValues]];
        }
    }
    return resultArray;
}

- (NSString *)toJson
{
    NSError *parseError = nil;
    NSDictionary *keyValues = [self bxhkeyValues];
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:keyValues options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - private
- (NSString *)propertyClassName:(NSString *)code
{
   if (code.length > 3 && [code hasPrefix:@"@\""])
    {
        // 去掉@"和"，截取中间的类型名称
        return [code substringWithRange:NSMakeRange(2, code.length - 3)];
        
    }
    return @"";
}

- (BOOL)boolType:(NSString *)code
{

    BOOL result = [code compare:BXHPropertyTypeBOOL1
                         options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
    if (result)
    {
        return YES;
    }

    result = [code compare:BXHPropertyTypeBOOL2
                         options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
    if (result)
    {
        return YES;
    }

    return NO;
}
@end
