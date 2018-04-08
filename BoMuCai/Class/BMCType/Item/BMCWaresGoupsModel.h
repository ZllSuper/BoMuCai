//
//  BMCWaresGoupsModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

// 商品排列组合	id：组合id， propertyValue：属性id组合逗号分隔 amount：库存 unitPrice：单价

@interface BMCWaresGoupsModel : NSObject

@property (nonatomic, copy) NSString *waresId;

@property (nonatomic, copy) NSString *propertyValue;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *unitPrice;

@end
