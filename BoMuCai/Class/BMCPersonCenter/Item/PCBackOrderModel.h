//
//  PCBackOrderModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGoodsModel.h"

@interface PCBackOrderModel : NSObject

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, copy) NSString *orderId; //	总订单ID

@property (nonatomic, copy) NSString *shopId;//	商户ID

@property (nonatomic, copy) NSString *shopName; //	商户名称

@property (nonatomic, copy) NSString *shopBuyNum; //

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *rejectedStatus;

@property (nonatomic, copy) NSString *rejectedStatusName;

@property (nonatomic, copy) NSString *rejectedRemark;

@property (nonatomic, copy) NSString *refuseReason;

@property (nonatomic, copy) NSString *manageReason;

@property (nonatomic, copy) NSString *yunfei;

@property (nonatomic, strong) NSArray *orderRejectedDtoList; //	订单产品列表

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, copy) NSString *createDate;

@end

