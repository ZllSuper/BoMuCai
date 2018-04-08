//
//  NSURL+BXHUrl.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/5/27.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "NSURL+BXHUrl.h"
#import <objc/runtime.h>

@implementation NSURL (BXHUrl)

//+ (void) initialize
//{
//    if (![NSStringFromClass(self) isEqualToString:NSStringFromClass([NSURL class])])
//    {
//        return;
//    }
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originalSelector = @selector(URLWithString:);
//        SEL swizzledSelector = @selector(bxh_URLWithString:);
//        [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
//    });
//}

#pragma maker - LifeCycle
+ (NSURL *)bxh_URLWithString:(NSString *)URLString
{
    if ([NSString stringIsEmpty:URLString])
    {
        URLString = @"";
    }
    NSString* encodedString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self bxh_URLWithString:[encodedString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
}

+ (NSURL *)encodeURLWithString:(NSString *)URLString
{
    if ([NSString stringIsEmpty:URLString])
    {
        URLString = @"";
    }
    NSString* encodedString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self URLWithString:[encodedString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
}

#pragma private
+ (void)selector_exchangeImpWithOrginalSelectior:(SEL)orginalSelector AndSwizzledSelector:(SEL)swizzledSelector
{
    Method orginalMethod = class_getClassMethod(self, orginalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        IMP imp = NULL;
         imp = class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod));
        if (!imp)
        {
            imp = method_getImplementation(orginalMethod);
            IMP swizzledImp = method_getImplementation(swizzledMethod);
            method_setImplementation(orginalMethod, swizzledImp);
            method_setImplementation(swizzledMethod, imp);
        }
    }
    else
    {
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
}

@end
