//
//  PCOrderDetailModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/13.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGoodsModel.h"
#import "PCAddressModel.h"

@interface PCOrderDetailModel : NSObject

@property (nonatomic, copy) NSString *oid;

@property (nonatomic, copy) NSString *orderId; //	总订单ID

@property (nonatomic, copy) NSString *shopId; //	商户ID

@property (nonatomic, copy) NSString *shopName; //	商户名称

@property (nonatomic, copy) NSString *shopPhone; //	门店电话

@property (nonatomic, copy) NSString *shopBuyNum; //	门店购买商品数

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

@property (nonatomic, copy) NSString *updateDate; //	状态时间

@property (nonatomic, copy) NSString *endDate; //	终止时间

@property (nonatomic, copy) NSString *couponId;

@property (nonatomic, copy) NSString *couponName;

@property (nonatomic, copy) NSString *couponPrice;

@property (nonatomic, strong) PCAddressModel *orderDto; //	总订单信息
//id	总订单ID
//userId	用户ID
//payType	支付方式
//payStatus	支付状态
//payDate	支付时间
//name	收货人
//phone	联系电话
//province	省
//provinceName
//city	市
//cityName
//area	区
//areaName
//address	地址
@property (nonatomic, strong) NSArray *orderMdseDtoList; //	订单产品列表
//id	产品ID
//name	产品名称
//image	产品图片
//propertyValueName	型号
//buyNum	购买数量
//unitPrice	单价

@end
