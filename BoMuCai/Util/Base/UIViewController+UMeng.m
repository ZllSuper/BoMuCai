//
//  UIViewController+UMeng.m
//  BoMuCai
//
//  Created by liangliang.zhu on 2018/5/7.
//  Copyright © 2018年 woshishui. All rights reserved.
//

#import "UIViewController+UMeng.h"
#import <UMAnalytics/MobClick.h>

@implementation UIViewController (UMeng)

+ (void)load
{
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
    swizzleMethod([self class], @selector(viewDidDisappear:), @selector(swizzled_viewDidDisappear:));
}

- (void)swizzled_viewDidAppear:(BOOL)animated
{    // call original implementation
    [self swizzled_viewDidAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)swizzled_viewDidDisappear:(BOOL)animated
{    // call original implementation
    [self swizzled_viewDidDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)  {    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
