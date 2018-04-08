//
//  UIViewController+EmptyView.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/11/17.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "UIViewController+EmptyView.h"
#import <objc/runtime.h>

@implementation UIViewController (EmptyView)

static char kEmptyView;

- (void)setEmptyView:(BXHEmptyShowView *)emptyView
{
    objc_setAssociatedObject(self, &kEmptyView, emptyView, OBJC_ASSOCIATION_RETAIN);
}

- (BXHEmptyShowView *)emptyView
{
    return objc_getAssociatedObject(self, &kEmptyView);
}

@end
