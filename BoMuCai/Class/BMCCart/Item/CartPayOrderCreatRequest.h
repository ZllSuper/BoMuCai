//
//  CartPayOrderCreatRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

//payType  支付类型（ALIPAY = "01700001"，UNIONPAY = "01700003"，WECHATPAY = "01700002"）

@interface CartPayOrderCreatRequest : BaseMainRequest

@property (nonatomic, copy) NSString *orderId; //	订单编号

@property (nonatomic, copy) NSString *payType; //	支付分类

@property (nonatomic, copy) NSString *spbillCreateIp; // 手机ip

@end
