//
//  UIViewController+SwizzledController.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/1/28.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "UIViewController+SwizzledController.h"
#import <objc/runtime.h>

@implementation UIViewController (SwizzledController)

+ (void) initialize
{
    if (![NSStringFromClass(self) isEqualToString:NSStringFromClass([UIViewController class])])
    {
        return;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(bxh_viewWillAppear:);
        [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
        originalSelector = @selector(viewDidLoad);
        swizzledSelector = @selector(bxh_viewDidLoad);
        [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
        originalSelector = @selector(viewWillDisappear:);
        swizzledSelector = @selector(bxh_viewWillDisAppear:);
        [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
        
//        originalSelector = NSSelectorFromString(@"dealloc");
//        swizzledSelector = @selector(bxh_dealloc);
//        [self selector_exchangeImpWithOrginalSelectior:originalSelector AndSwizzledSelector:swizzledSelector];
    });
}



#pragma maker - LifeCycle
- (void)bxh_viewDidLoad
{
    [self bxh_viewDidLoad];
    if ([self isKindOfClass:[UINavigationController class]])
    {
    }
    else if (self.navigationController)
    {
        self.view.backgroundColor = Color_Gray_bg;
        self.view.exclusiveTouch = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
}

- (void)bxh_viewWillAppear:(BOOL)animated
{
    [self bxh_viewWillAppear:animated];
}

- (void)bxh_viewWillDisAppear:(BOOL)animated
{
    [self bxh_viewWillDisAppear:animated];
    [self.view endEditing:YES];
}

- (void)bxh_dealloc
{
    BXHLog(@"delloc %@",self);
}

#pragma private 
+ (void)selector_exchangeImpWithOrginalSelectior:(SEL)orginalSelector AndSwizzledSelector:(SEL)swizzledSelector
{
    Method orginalMethod = class_getInstanceMethod(self, orginalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod));
    }
    else
    {
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
}
@end
