//
//  ShopCouponBtn.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/22.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCouponModel.h"

@interface ShopCouponBtn : UIButton

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, weak) ShopCouponModel *weakModel;

@end
