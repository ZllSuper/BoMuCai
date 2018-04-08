//
//  BXHTabBarController.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/1.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHTabBar.h"

@interface BXHTabBarController : UIViewController

@property (nonatomic, strong) NSArray *controllers;

@property (nonatomic, readonly, strong) BXHTabBar *tabBar;

- (void)setTabBarHidden:(BOOL)hidden animate:(BOOL)animate;

- (void)setSelectControllerAtIndex:(NSInteger)index;

- (void)logOut;

@end
