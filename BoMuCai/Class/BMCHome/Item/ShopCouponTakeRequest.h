//
//  ShopCouponTakeRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface ShopCouponTakeRequest : BaseMainRequest

@property (nonatomic, copy) NSString *shopId; //店铺ID

@property (nonatomic, copy) NSString *userId; //	用户ID

@property (nonatomic, copy) NSString *couponId; //	优惠券ID

@end
