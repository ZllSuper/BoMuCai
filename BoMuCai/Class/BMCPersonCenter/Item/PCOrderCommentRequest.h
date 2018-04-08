//
//  PCOrderCommentRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/5/26.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCOrderCommentRequest : BaseMainRequest

@property (nonatomic, copy) NSString *mdseId; //	商户订单

@property (nonatomic, copy) NSString *userId; //	用户ID

@property (nonatomic, copy) NSString *starLevel; //	星级

@property (nonatomic, copy) NSString *introduce; //	评价

@end
