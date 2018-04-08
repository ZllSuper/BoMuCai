//
//  PCGoodsModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCGoodsModel : NSObject

@property (nonatomic, copy) NSString *goodsId;	//产品ID

@property (nonatomic, copy) NSString *name; //	产品名称

@property (nonatomic, copy) NSString *image;//	产品图片

@property (nonatomic, copy) NSString *propertyValueName; //	型号

@property (nonatomic, copy) NSString *buyNum; //	购买数量

@property (nonatomic, copy) NSString *unitPrice; //	单价

@end
