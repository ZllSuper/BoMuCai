//
//  PCCollectGoodsTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCCollectGoodsTableView.h"

@implementation PCCollectGoodsTableView

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
    PCCollectListRequest *request = [[PCCollectListRequest alloc] init];
    request.type = @"01900001";
    request.userId = KAccountInfo.userId;
    request.curPage = [NSString stringWithFormat:@"%ld",self.page];
    request.pageSize = @"10";
    [request requestWithSuccess:^( BXHBaseRequest *request) {
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
        ToastShowBottom(NetWorkErrorTip);
        [weakSelf endRefresh];
    }];
}

- (void)delCollectRequest:(BMCWaresModel *)waresModel
{
    __weak typeof(self) weakSelf = self;
    __block BMCWaresModel *blockModel = waresModel;
    BMCDelCollectRequest *item = [[BMCDelCollectRequest alloc] init];
    item.unCollectId = waresModel.waresId;
    item.type = @"0";
    item.collectStu = @"01900001";
    item.userId = KAccountInfo.userId;
    ProgressShow(self.superview);
    [item requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            NSInteger index = [weakSelf.soureAry indexOfObject:blockModel];
            [weakSelf.soureAry removeObject:blockModel];
            if (weakSelf.soureAry.count > 0)
            {
                [weakSelf deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            }
            else
            {
                [weakSelf reloadData];
            }
            
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        
    } failure:^(NSError *error, BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
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


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self delCollectRequest:self.soureAry[indexPath.row]];
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
