//
//  ShopActivityListTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopActivityListTableView.h"

@implementation ShopActivityListTableView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:CGRectZero style:style])
    {
        [self creatHeader];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:[HomeActivityCell className] bundle:nil] forCellReuseIdentifier:[HomeActivityCell className]];
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;

    HomeActivityRequest *activityRequest = [[HomeActivityRequest alloc] init];
    activityRequest.curPage = @"1";
    activityRequest.pageSize = @"1000";
    activityRequest.type = @"0";
    activityRequest.shopId = self.shopId;
    [activityRequest requestWithSuccess:^( BXHBaseRequest *request) {
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            [weakSelf.soureAry addObjectsFromArray:[BMCActivityModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
            [weakSelf reloadData];
            
        }
        else
        {
            ToastShowBottom(request.response.message);
        }
        [weakSelf endRefresh];
    } failure:^(NSError *error, BXHBaseRequest *request) {
        [weakSelf endRefresh];
        ToastShowBottom(NetWorkErrorTip);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.soureAry.count / 2;
    if((self.soureAry.count % 2) != 0)
    {
        count ++;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeActivityCell className]];
    cell.delegate = self;
    NSInteger letfIndex = indexPath.row * 2;
    NSInteger rightIndex = letfIndex + 1;
    
    cell.leftModel = self.soureAry[letfIndex];
    if (rightIndex >= self.soureAry.count)
    {
        cell.rightModel = nil;
    }
    else
    {
        cell.rightModel = self.soureAry[rightIndex];
    }

    return cell;
}

- (void)activityCell:(HomeActivityCell *)cell cellItemAction:(BMCActivityModel *)model
{
    if (self.itemActionDelegate)
    {
        [self.itemActionDelegate tableView:self cellItemAction:model];
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
