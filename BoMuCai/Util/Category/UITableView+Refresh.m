//
//  UITableView+MJRefresh.m
//  DTMPlus
//
//  Created by chengzhitong on 15/11/2.
//  Copyright © 2015年 chengzhitong. All rights reserved.
//

#import "UITableView+Refresh.h"
#import "MJRefresh.h"

const char emptyViewChar;
const char separatorStyleChar;

@implementation UITableView (Refresh)

- (void)addRefreshNoWordTarget:(id)target action:(SEL)downAction
{
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:downAction];
    header.arrowView.image = nil;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.mj_header = header;
}
- (void)addRefreshTarget:(id)target downAction:(SEL)downAction
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:downAction];
}

- (void)addRefreshTarget:(id)target upAction:(SEL)upAction downAction:(SEL)downAction
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:downAction];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:upAction];
}

- (void)endRefresh
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)configDataIsEnd:(BOOL)isEnd
{
    if (isEnd) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.mj_footer resetNoMoreData];
    }
}




@end
