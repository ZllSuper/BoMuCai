//
//  BaseTableView.h
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/15.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHRefreshHeader.h"
#import "BXHRefreshFooter.h"

@class BaseTableView;

typedef void (^TableCellSelect)(BaseTableView *tableView,NSIndexPath *indexPath);

typedef void (^TableViewRefreshCallBack)(BaseTableView *tableView,BOOL success);

@interface BaseTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *soureAry;

@property (nonatomic, copy) TableCellSelect callBack;

@property (nonatomic, copy) TableViewRefreshCallBack refreshCallBack;

@property (nonatomic, assign) NSInteger page;

- (void)creatHeader;

- (void)creatFooter;

- (void)requestViewSource:(BOOL)refresh;

- (void)tableViewDidSelectCallBack:(TableCellSelect)callBack;

- (void)tableViewRefreshCallBack:(TableViewRefreshCallBack)refreshCallBack;

@end
