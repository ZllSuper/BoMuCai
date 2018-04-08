//
//  PCOrderListGetRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

#define Request_WaitPayType @"01500001"
#define Request_WaitSendType @"01500002"
#define Request_WaitReceive @"01500003"

@interface PCOrderListGetRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId; //	会员ID

@property (nonatomic, copy) NSString *requestType; //	待付款:01500001  待发货:01500002  待收货:01500003

@end
