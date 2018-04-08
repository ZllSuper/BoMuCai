//
//  WaresDetailTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "WaresDetailAdCell.h"
#import "WaresInfoCell.h"
#import "WaresShopCell.h"
#import "WaresSectionHeaderView.h"
#import "WaresDetailWebCell.h"
#import "WaresCommentCell.h"
#import "WaresCommentFooterView.h"
#import "WaresCommendSectionHeader.h"
#import "WaresDetailItemCell.h"
#import "WaresTypeCell.h"

#import "WaresDetailRequest.h"
#import "BMCWaresDetailModel.h"

@class WaresDetailTableView;
@protocol WaresDetailTableViewProtcol <NSObject>

- (void)tableView:(WaresDetailTableView *)tableView itemAction:(WaresDetailItem *)item;

- (void)tableView:(WaresDetailTableView *)tableView AdViewActionIndex:(NSInteger)index;

@end

@interface WaresDetailTableView : BaseTableView <WaresSectionHeaderViewDelegate,WaresDetailWebCellDelegate,WaresDetailItemCellDelegate,DTAdViewDelagate>

@property (nonatomic, strong) WaresDetailAdCell *adCell;

@property (nonatomic, strong) WaresInfoCell *infoCell;

@property (nonatomic, strong) WaresShopCell *shopCell;

@property (nonatomic, strong) WaresTypeCell *typeChooseCell;

@property (nonatomic, strong) WaresSectionHeaderView *selSectionHeader;

@property (nonatomic, strong) WaresDetailWebCell *webCell;

@property (nonatomic, strong) WaresCommentCell *commentCell;

@property (nonatomic, strong) WaresCommentFooterView *moreFooterView;

@property (nonatomic, strong) WaresCommendSectionHeader *commendHeaderView;

@property (nonatomic, strong) WaresDetailItemCell *itemCell;

@property (nonatomic, copy)  NSString *detailId;

@property (nonatomic, strong) BMCWaresDetailModel *detailModel;

@property (nonatomic, weak) id <WaresDetailTableViewProtcol>protcol;

@end
