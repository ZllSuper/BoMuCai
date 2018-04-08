//
//  PCBackGoodsTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "PCOrderHeaderView.h"
#import "CarOrderInputCell.h"
#import "OrderFooterView.h"
#import "PCOrderProtcol.h"

#import "PCBackOrderListRequest.h"

#import "PCBackOrderModel.h"

@interface PCBackGoodsTableView : BaseTableView <PCOrderHeaderViewDelegate>

@property (nonatomic, weak) id <PCOrderProtcol>orderDelegate;

@end
