//
//  ShopActivityListTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "HomeActivityCell.h"
#import "HomeActivityRequest.h"

@class ShopActivityListTableView;

@protocol ShopActivityListTableViewDelegate <NSObject>

- (void)tableView:(ShopActivityListTableView *)tableView cellItemAction:(BMCActivityModel *)model;

@end

@interface ShopActivityListTableView : BaseTableView <HomeActivityCellDelegate>

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, weak) id <ShopActivityListTableViewDelegate>itemActionDelegate;

@end
