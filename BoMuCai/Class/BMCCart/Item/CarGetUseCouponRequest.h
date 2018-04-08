//
//  CarGetUseCouponRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface CarGetUseCouponRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId; //	用户编号

@property (nonatomic, copy) NSString *shopId; //	商户编号

@property (nonatomic, copy) NSString *amount; //	金额

@end
