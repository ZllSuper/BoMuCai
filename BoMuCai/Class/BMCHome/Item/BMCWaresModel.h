//
//  BMCWaresModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCWaresModel : NSObject

@property (nonatomic, copy) NSString *waresId;

@property (nonatomic, copy) NSString *name; //货物名称

@property (nonatomic, copy) NSString *image; //货物图片

@property (nonatomic, copy) NSString *shopName; //店铺名称

@property (nonatomic, copy) NSString *unitPrice; //单价

@property (nonatomic, copy) NSString *amount; //数量

@property (nonatomic, copy) NSString *assessNum; //评价数量

@end
