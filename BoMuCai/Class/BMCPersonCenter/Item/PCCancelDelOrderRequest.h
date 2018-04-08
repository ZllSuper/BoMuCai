//
//  PCCancelDelOrderRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCCancelDelOrderRequest : BaseMainRequest

@property (nonatomic, copy) NSString *orderId; //	商户订单ID

@property (nonatomic, copy) NSString *userId; //	会员ID

@property (nonatomic, copy) NSString *remark; //	退款原因

@end
