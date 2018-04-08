//
//  BaseNaviController.m
//  MeiZhan
//
//  Created by zhitong on 15/6/1.
//  Copyright (c) 2015年 shfugu. All rights reserved.
//

#import "BaseNaviController.h"
//#import "CenterViewController.h"

@interface BaseNaviController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNaviController

- (void)dealloc
{
}

+ (void)load
{
//    [[UINavigationBar appearance] setBarTintColor:Color_NavigationBar];
//    [[UINavigationBar appearance] setTintColor:Color_NavigationBar];
//
    [[UINavigationBar appearance] setBackgroundImage:ImageWithColor(Color_White) forBarMetrics:UIBarMetricsDefault];

    [[UITableView appearance] setSeparatorColor:Color_Gray_Line];
    [[UITableView appearance] setBackgroundColor:Color_Clear];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_BarText,NSFontAttributeName:Font_sys_17}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationBar.clipsToBounds = YES;
    self.navigationBar.translucent = NO;
//    self.navigationBar.backgroundColor = Color_NavigationBar;
    self.navigationBar.exclusiveTouch = YES;
//    self.view.backgroundColor = Color_White;
//    self.view.backgroundColor = Color_Gray_bg;
//    self.view.exclusiveTouch = YES;
    self.popPanEnable = YES;
    
 
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    @synchronized(self){
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
        if (self.viewControllers.count != 0)
        {
            viewController.hidesBottomBarWhenPushed = YES;
            [self initNavigationBackItemToVC:viewController];
        }
        [super pushViewController:viewController animated:animated];
    }
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if([MainAppDelegate.mainTabBarController.controllers containsObject:navigationController])
    {
        BOOL hidden = navigationController.viewControllers.count > 1;
        if (!hidden)
        {
            [MainAppDelegate.mainTabBarController setTabBarHidden:hidden animate:NO];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([MainAppDelegate.mainTabBarController.controllers containsObject:navigationController])
    {
        BOOL hidden = navigationController.viewControllers.count > 1;
        if (hidden)
        {
            [MainAppDelegate.mainTabBarController setTabBarHidden:hidden animate:NO];
        }
    }
}

- (void)initNavigationBackItemToVC:(UIViewController *)vc
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:ImageWithName(@"PublicBackArrow") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backActionClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 19, 25);
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backActionClick
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.popPanEnable;
}

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    
//    
//    
//    
//    NavigationAnimationViewController *navigationAnimation = [NavigationAnimationViewController new];
//    navigationAnimation.bPush = (operation == UINavigationControllerOperationPush);
//    
//    return navigationAnimation;
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
//{
//    
//    
//    return  nil;
//}



@end
