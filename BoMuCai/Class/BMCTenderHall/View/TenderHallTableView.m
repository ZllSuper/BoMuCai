//
//  TenderHallTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "TenderHallTableView.h"

@implementation TenderHallTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatFooter];
        [self creatHeader];
        self.sortModel = [[TenderHallSortModel alloc] init];
        [self registerNib:[UINib nibWithNibName:[TenderHallCell className] bundle:nil] forCellReuseIdentifier:[TenderHallCell className]];
    }
    return self;
}

#pragma mark - request
- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    TenderHallSearchRequest *request = [[TenderHallSearchRequest alloc] init];
    request.curPage = [NSString stringWithFormat:@"%ld",self.page];
    request.pageSize = @"10";
    request.typeId = self.sortModel.typeId;
    request.tenderStatus = self.sortModel.statueId;
    request.startStamp = StringIsEmpty(self.sortModel.startTime) ? @"" : _StrFormate(@"%ld",(NSInteger)([NSDate timeSince1970Date:self.sortModel.startTime withFormate:@"yyyy-MM-dd"] * 1000));
    request.endStamp = StringIsEmpty(self.sortModel.endTime) ? @"" : _StrFormate(@"%ld",(NSInteger)([NSDate timeSince1970Date:self.sortModel.endTime withFormate:@"yyyy-MM-dd"] * 1000));;
    request.address = self.sortModel.proId;
    request.nameLike = self.sortModel.nameLike;
    //    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        //        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            [weakSelf.soureAry addObjectsFromArray:[TenderHallModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
            [weakSelf reloadData];
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        //        ProgressHidden(weakSelf.superview);
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
    }];
}

#pragma mark - delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.soureAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TenderHallCell *cell = [tableView dequeueReusableCellWithIdentifier:[TenderHallCell className]];
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
