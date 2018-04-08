//
//  PCOrderProtcol.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCOrderHeaderView.h"
#import "PCWaitPaySectionFooterView.h"

#ifndef PCOrderProtcol_h
#define PCOrderProtcol_h

@protocol PCOrderProtcol <NSObject>

@optional
- (void)tableView:(UITableView *)tableView  headerViewAction:(PCOrderHeaderView *)headerView;

- (void)tableView:(UITableView *)tableView  phoneCallBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  payBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  cancelOrderBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  remindBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  backGoodsBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  lookFreBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView  confirmReceiveBtnAction:(PCWaitPaySectionFooterView *)headerView;

- (void)tableView:(UITableView *)tableView commentBtnAction:(PCWaitPaySectionFooterView *)headerView;

@end

#endif /* PCOrderProtcol_h */
