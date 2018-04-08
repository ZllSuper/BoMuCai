//
//  CarGoodsTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "CarGoodsCell.h"
#import "CarSectionHeaderView.h"

#import "MyCartListRequest.h"
#import "CartGoodsDelRequest.h"
#import "CartGoodsNumChangeRequest.h"

#import "CarShopModel.h"

@class CarGoodsTableView;

@protocol CarGoodsTableViewDelegate <NSObject>

- (void)tableViewGoodsSelect:(CarGoodsTableView *)tableView;

- (void)tableViewGoodsNumChange:(CarGoodsTableView *)tableView;

- (void)tableView:(CarGoodsTableView *)tableView sectionHeaderAction:(CarShopModel *)model;

@end

@interface CarGoodsTableView : BaseTableView <CarSectionHeaderViewDelegate, CarGoodsCellDelegate>

@property (nonatomic, weak) id <CarGoodsTableViewDelegate>selectDelegate;

@end
