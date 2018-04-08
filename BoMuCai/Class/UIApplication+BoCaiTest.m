//
//  UIApplication+BoCaiTest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/11/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "UIApplication+BoCaiTest.h"

@implementation UIApplication (BoCaiTest)

+ (void)load
{
    [self swizzed:@selector(openURL:) newMethod:@selector(bxh_openURL:)];
    [self swizzed:@selector(openURL:options:completionHandler:) newMethod:@selector(bxh_openURL:options:completionHandler:)];

    
}

+ (void)swizzed:(SEL)originalSel newMethod:(SEL)newSel
{
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
}

- (BOOL)bxh_openURL:(NSURL*)url
{
    
    return [self bxh_openURL:url];
}


- (void)bxh_openURL:(NSURL*)url options:(NSDictionary<NSString *, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion
{
    
    [self bxh_openURL:url options:options completionHandler:completion];
}


@end
