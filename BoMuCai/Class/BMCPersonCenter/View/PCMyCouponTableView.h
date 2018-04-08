//
//  PCMyCouponTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "CarCouponCell.h"
#import "PCCouponHeaderView.h"

#import "PCMyCouponListRequest.h"

@interface PCMyCouponTableView : BaseTableView

@property (nonatomic, strong) PCCouponHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *effectCouponList;

@property (nonatomic, strong) NSMutableArray *invalidCouponList;

@end
