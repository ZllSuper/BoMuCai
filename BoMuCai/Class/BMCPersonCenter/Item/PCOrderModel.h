//
//  PCOrderModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGoodsModel.h"

@interface PCOrderModel : NSObject

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, copy) NSString *orderId; //	总订单ID

@property (nonatomic, copy) NSString *shopId; //	商户ID

@property (nonatomic, copy) NSString *shopName; //	商户名称

@property (nonatomic, copy) NSString *shopPhone;

@property (nonatomic, copy) NSString *shopBuyNum;

@property (nonatomic, copy) NSString *amount; //	订单金额

@property (nonatomic, copy) NSString *realAmount; //	订单修改金额

@property (nonatomic, copy) NSString *orderStatus; //	订单状态

@property (nonatomic, copy) NSString *orderStatusName; //	订单状态名称

@property (nonatomic, copy) NSString *cancelRemark; //	取消订单理由

@property (nonatomic, copy) NSString *cancelDate; //	取消订单时间

@property (nonatomic, copy) NSString *expressId; //	快递单号

@property (nonatomic, copy) NSString *expressCompany; //	快递公司ID

@property (nonatomic, copy) NSString *expressCompanyName; //	快递公司名称

@property (nonatomic, copy) NSString *expressPhone; //	快递电话

@property (nonatomic, copy) NSString *yunfei; //	运费

@property (nonatomic, strong) NSArray *orderMdseDtoList; //	订单产品列表

@property (nonatomic, copy) NSString *couponPrice; //

@end
