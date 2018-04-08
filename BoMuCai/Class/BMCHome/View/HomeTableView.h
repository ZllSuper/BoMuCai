//
//  HomeTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "HomeTopAdCell.h"
#import "HomeMidAdCell.h"
#import "HomeTypeCell.h"
#import "HomeActivityCell.h"
#import "BMCActivityModel.h"

@class HomeTableView;

@protocol HomeTableViewDelegate <NSObject>

//1支座 2锚具 3道桥材料 4更多
- (void)tableView:(HomeTableView *)tableView typeCellAction:(NSInteger)index;

- (void)tableView:(HomeTableView *)tableView activityAction:(HomeActivityCell *)cell itemModel:(BMCActivityModel *)model;

- (void)tableView:(HomeTableView *)tableView topAdCellActionIndex:(NSInteger)index;

- (void)tableView:(HomeTableView *)tableView midAdCellActionIndex:(NSInteger)index;

@end

@interface HomeTableView : BaseTableView <HomeTypeCellDelegate,DTAdViewDelagate,HomeActivityCellDelegate>

@property (nonatomic, strong) HomeTopAdCell *topAdCell;

@property (nonatomic, strong) HomeMidAdCell *midAdCell;

@property (nonatomic, strong) HomeTypeCell *typeCell;

@property (nonatomic, weak) id <HomeTableViewDelegate>actionDelegate;

@end
