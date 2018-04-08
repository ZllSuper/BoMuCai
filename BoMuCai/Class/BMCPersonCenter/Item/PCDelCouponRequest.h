//
//  PCDelCouponRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/5/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCDelCouponRequest : BaseMainRequest

@property (nonatomic, copy) NSString *couponId; //	优惠券ID  多个用逗号分隔

@property (nonatomic, copy) NSString *userId; //	用户ID

@end

