//
//  PCRemindSendRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCRemindSendRequest : BaseMainRequest

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *remark;

@end
