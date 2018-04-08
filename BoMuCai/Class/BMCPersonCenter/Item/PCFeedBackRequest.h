//
//  PCFeedBackRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/6/2.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCFeedBackRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId; //	用户编号

@property (nonatomic, copy) NSString *mdseId; //	商品编号

@property (nonatomic, copy) NSString *qDescription; //	问题描述

@property (nonatomic, copy) NSString *flag; //	0:商品投诉 1：体验问题

@end
