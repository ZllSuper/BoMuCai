//
//  PCBrowsingHistoryTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCBrowsingHistoryTableView.h"

@implementation PCBrowsingHistoryTableView
- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatFooter];
        [self creatHeader];
        
        [self registerNib:[UINib nibWithNibName:[WaresListCell className] bundle:nil] forCellReuseIdentifier:[WaresListCell className]];
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    BXHWeakObj(self);
    PCBrowingHistoryRequest *request = [[PCBrowingHistoryRequest alloc] init];
    request.curPage = _StrFormate(@"%ld",self.page);
    request.pageSize = @"10";
    request.userId = KAccountInfo.userId;
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [selfWeak.soureAry removeAllObjects];
            }
            [selfWeak.soureAry addObjectsFromArray:[BMCWaresModel bxhObjectArrayWithKeyValuesArray:request.response.data[@"historyDtos"]]];
            [selfWeak reloadData];
            
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [selfWeak endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        [selfWeak endRefresh];
        ToastShowBottom(NetWorkErrorTip);
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soureAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaresListCell *cell = [tableView dequeueReusableCellWithIdentifier:[WaresListCell className]];
    cell.weakModel = self.soureAry[indexPath.row];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
