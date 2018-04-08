//
//  UIViewController+Extend.m
//  Category
//
//  Created by Evan.Cheng on 15/12/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "UIViewController+Extend.h"
#import "NSObject+property.h"
#import "BaseNaviController.h"

@implementation UIViewController (Extend)

- (BOOL)checkIsLogin
{
    if ([NSString stringIsEmpty:KAccountInfo.userId])
    {
        BMCLoginViewController *vc = [[BMCLoginViewController alloc] init];
        [MainAppDelegate.mainTabBarController presentViewController:[[BaseNaviController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)goToLoginVc
{
    BMCLoginViewController *vc = [[BMCLoginViewController alloc] init];
    [MainAppDelegate.mainTabBarController presentViewController:[[BaseNaviController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)removeAllChildViewController
{
    for (UIViewController *childController in self.childViewControllers)
    {
        [childController removeFromParentViewController];
    }
}

UIViewController * InstantiateViewControllerFromXIB(Class VCClassName)
{
    return [[[VCClassName class] alloc] initWithNibName:NSStringFromClass([VCClassName class]) bundle:nil];
}

- (void)popToViewController:(Class)VCClassName
{
    if (self.navigationController) {
        NSArray * vcAry = self.navigationController.viewControllers;
        for (UIViewController * vc in vcAry) {
            if ([vc isMemberOfClass:[VCClassName class]]) {
                [self.navigationController popToViewController:vc animated:YES]; break;
            }
        }
    }
}

- (UIViewController *)pushToViewController:(Class)VCClassName
{
    UIViewController * vc = [[[VCClassName class] alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (UIViewController *)pushToXIBViewController:(Class)VCClassName;
{
    UIViewController * vc = [[[VCClassName class] alloc] initWithNibName:NSStringFromClass(VCClassName) bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (UIViewController *)pushToViewController:(Class)VCClassName toParamDict:(NSDictionary *)paramDict
{
    UIViewController * vc = [[[VCClassName class] alloc] init];
    NSArray * keyAry = [paramDict allKeys];
    NSArray * propertyList = [VCClassName PropertyListArray];
    for (NSString * key in keyAry) {
        if ([propertyList containsObject:key]) {
            [vc setValue:paramDict[key] forKey:key];
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (UIViewController *)pushToXIBViewController:(Class)VCClassName toParamDict:(NSDictionary *)paramDict
{
    UIViewController * vc = [[[VCClassName class] alloc] initWithNibName:NSStringFromClass(VCClassName) bundle:nil];
    NSArray * keyAry = [paramDict allKeys];
    NSArray * propertyList = [VCClassName PropertyListArray];
    for (NSString * key in keyAry) {
        if ([propertyList containsObject:key]) {
            [vc setValue:paramDict[key] forKey:key];
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (UIViewController *)presentViewController:(Class)VCClassName
{
    UIViewController * vc = [[[VCClassName class] alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    return vc;
}

- (UIViewController *)presentXIBViewController:(Class)VCClassName
{
    UIViewController * vc = [[[VCClassName class] alloc] initWithNibName:NSStringFromClass(VCClassName) bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    return vc;
}


@end
