//
//  PCAllOrderTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "PCOrderHeaderView.h"
#import "CarOrderInputCell.h"
#import "PCWaitPaySectionFooterView.h"
#import "PCOrderProtcol.h"

#import "PCOrderListGetRequest.h"

@interface PCAllOrderTableView : BaseTableView <PCOrderHeaderViewDelegate,PCWaitPaySectionFooterViewDelegate>

@property (nonatomic, weak) id <PCOrderProtcol>orderDelegate;

@end
