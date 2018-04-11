//
//  PCAddressManagerTableView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressManagerTableView.h"

@implementation PCAddressManagerTableView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self creatHeader];
        [self registerNib:[UINib nibWithNibName:[PCAddressManagerCell className] bundle:nil] forCellReuseIdentifier:[PCAddressManagerCell className]];
        
    }
    return self;
}

- (void)requestViewSource:(BOOL)refresh
{
    __weak typeof(self) weakSelf = self;
    PCAddressListRequest *request = [[PCAddressListRequest alloc] init];
    request.userId = KAccountInfo.userId;
//    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
//        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            if (refresh)
            {
                [weakSelf.soureAry removeAllObjects];
            }
            
            [weakSelf.soureAry addObjectsFromArray:[PCAddressModel bxhObjectArrayWithKeyValuesArray:request.response.data]];
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

- (void)setDefaultAddressRequest:(PCAddressModel *)addressModel
{
    __weak typeof(self) weakSelf = self;
    __block typeof(addressModel) blModel = addressModel;
    PCAddressSetDetaultRequest *request = [[PCAddressSetDetaultRequest alloc] init];
    request.addressId = addressModel.addressId;
    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            for (PCAddressModel *addresModel in weakSelf.soureAry)
            {
                if ([blModel isEqual:addresModel] && ![blModel.isDefault boolValue])
                {
                    addresModel.isDefault = @"1";
                }
                else
                {
                    addresModel.isDefault = @"0";
                }
            }
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

- (void)addressDelRequest:(PCAddressModel *)delModel
{
    __weak typeof(self) weakSelf = self;
    __block typeof(delModel) blModel = delModel;
    PCDelAddressRequest *request = [[PCDelAddressRequest alloc] init];
    request.addressId = delModel.addressId;
    ProgressShow(self.superview);
    [request requestWithSuccess:^( BXHBaseRequest *request) {
        ProgressHidden(weakSelf.superview);
        if ([request.response.code isEqualToString:@"0000"])
        {
            NSInteger section = [weakSelf.soureAry indexOfObject:blModel];
            [weakSelf.soureAry removeObject:blModel];
            [weakSelf deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationRight];
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

#pragma mark - cellDelegate
- (void)addressManagerCellEditBtnAction:(PCAddressManagerCell *)cell
{
    [self.protocol tableVIew:self editCell:cell];
}

- (void)addressManagerCellDelBtnAction:(PCAddressManagerCell *)cell
{
    self.willDelectModel = cell.weakModel;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"确定要删除改地址吗"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 100;
    [alertView show];
}

- (void)addressManagerCellDefaultBtnAction:(PCAddressManagerCell *)cell
{
    [self setDefaultAddressRequest:cell.weakModel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.soureAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCAddressModel *model = self.soureAry[indexPath.section];
    return [PCAddressManagerCell cellHeightWithAddressDetail:[model composeAddressStr]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCAddressManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:[PCAddressManagerCell className]];
    cell.delegate = self;
    cell.weakModel = self.soureAry[indexPath.section];
    return cell;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self addressDelRequest:self.willDelectModel];
        }
    }
}

@end
