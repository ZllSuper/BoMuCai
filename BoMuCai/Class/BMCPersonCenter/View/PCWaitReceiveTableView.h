//
//  PCWaitReceiveTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "PCOrderHeaderView.h"
#import "PCWaitPaySectionFooterView.h"
#import "CarOrderInputCell.h"
#import "PCOrderProtcol.h"

#import "PCOrderListGetRequest.h"

#import "PCOrderModel.h"

@interface PCWaitReceiveTableView : BaseTableView<PCOrderHeaderViewDelegate,PCWaitPaySectionFooterViewDelegate>

@property (nonatomic, weak) id <PCOrderProtcol>orderDelegate;

@end
