//
//  TenderHallTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "TenderHallCell.h"

#import "TenderHallSearchRequest.h"

#import "TenderHallModel.h"
#import "TenderHallSortModel.h"

@interface TenderHallTableView : BaseTableView

@property (nonatomic, strong) TenderHallSortModel *sortModel;

@end
