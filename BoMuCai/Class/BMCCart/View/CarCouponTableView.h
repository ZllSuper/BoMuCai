//
//  CarCouponTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "CarCouponCell.h"
#import "CarGetUseCouponRequest.h"

@interface CarCouponTableView : BaseTableView

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *amount;

@end
