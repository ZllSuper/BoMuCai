//
//  BaseTableView.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/2/15.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = Color_Clear;
        self.delegate = self;
        self.dataSource = self;
        self.soureAry = [NSMutableArray array];
        self.page = 1;
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        self.soureAry = [NSMutableArray array];
        self.page = 1;
    }
    return self;
}

#pragma mark - public
- (void)requestViewSource:(BOOL)refresh
{

}

- (void)tableViewDidSelectCallBack:(TableCellSelect)callBack
{
    self.callBack = callBack;
}

- (void)tableViewRefreshCallBack:(TableViewRefreshCallBack)refreshCallBack
{
    self.refreshCallBack = refreshCallBack;
}

- (void)creatFooter
{
    self.mj_footer = [BXHRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
}

- (void)creatHeader
{
    self.mj_header = [BXHRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
}

#pragma mark - private

- (void)headerRefreshAction
{
    self.page = 1;
    [self requestViewSource:YES];
}

- (void)footerRefreshAction
{
    self.page ++;
    [self requestViewSource:NO];
}


#pragma mark - TableDataSource / delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soureAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (self.callBack)
    {
        self.callBack(self,indexPath);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
