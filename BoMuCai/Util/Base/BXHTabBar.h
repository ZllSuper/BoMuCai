//
//  BXHTabBar.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/1.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXHTabBarItem : UIControl

- (void)setTextColor:(UIColor *)color forState:(BOOL)selected;

- (void)setImage:(UIImage *)image forState:(BOOL)selected;

@property (nonatomic, copy) NSString *titleText;

@end

#define TabBarHeight 48.0

#define ItemGap 0.0

@class BXHTabBar;

@protocol BXHTabBarDelegate <NSObject>

- (BOOL)tabBar:(BXHTabBar *)tabBar selectItemAtIndex:(NSInteger)index;

@end

@interface BXHTabBar : UIView

@property (nonatomic, strong) NSArray <BXHTabBarItem *>*items;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id <BXHTabBarDelegate> delelgate;

- (void)setItemSelectAtIndex:(NSInteger)index;

@end
