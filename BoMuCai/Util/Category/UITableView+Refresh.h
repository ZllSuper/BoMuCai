//
//  UITableView+MJRefresh.h
//  DTMPlus
//
//  Created by chengzhitong on 15/11/2.
//  Copyright © 2015年 chengzhitong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Refresh)

- (void)addRefreshNoWordTarget:(id)target action:(SEL)downAction;

- (void)addRefreshTarget:(id)target downAction:(SEL)downAction;

// 添加 上拉加载 下拉刷新
- (void)addRefreshTarget:(id)target upAction:(SEL)upAction downAction:(SEL)downAction;

// 结束刷新
- (void)endRefresh;
//
- (void)configDataIsEnd:(BOOL)isEnd;





@end
