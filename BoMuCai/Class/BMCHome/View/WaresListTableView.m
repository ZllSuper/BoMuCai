//
//  WaresListTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "WaresListTableView.h"

@implementation WaresListTableView

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
    __weak typeof(self) weakSelf = self;
    GoodsSearchRequest *request = [[GoodsSearchRequest alloc] init];
    request.searchName = self.searchName;
    request.pageSize = @"10";
    request.curPage = [NSString stringWithFormat:@"%ld",self.page];
    request.sortAccording = self.sortAccording;
    request.city = self.city;
    request.type = self.type;
    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            [weakSelf.soureAry addObjectsFromArray:[BMCWaresModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
            [weakSelf reloadData];
        
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
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
