//
//  UIViewController+NavigationItem.m
//  TableView
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 Evan.Cheng. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

@implementation UIViewController (NavigationItem)
- (void)initNavigationTitleView:(UIView *(^)(void))customView
{
    UIView * titleView = customView();
    self.navigationItem.titleView = titleView;
}

- (void)initLeftNavigationItemWithTitle:(NSString *)title
                                 target:(id)target
                                 action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initLeftNavigationItemWithImage:(NSString *)image
                                 target:(id)target
                                 action:(SEL)action
{
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.leftBarButtonItem.tintColor = Color_Clear;
//    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initRightNavigationItemWithTitle:(NSString *)title
                                  target:(id)target
                                  action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initRightNavigationItemWithImage:(NSString *)image
                                  target:(id)target
                                  action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStylePlain target:target action:action];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initLeftNavigationItemWithCustomButton:(void(^)(UIButton * btn))customButton
{
    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton(itemBtn);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initRightNavigationItemWithCustomButton:(void(^)(UIButton * btn))customButton
{
    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton(itemBtn);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}

- (void)initLeftNavigationItemWithCustomView:(void(^)(UIView * superView))customView
{
    UIView * itemView = [UIView new];
    customView(itemView);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];


}

- (void)initRightNavigationItemWithCustomView:(void(^)(UIView * superView))customView
{
    UIView * itemView = [UIView new];
    customView(itemView);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainText,NSFontAttributeName:Font_sys_14} forState:UIControlStateNormal];

}
@end
