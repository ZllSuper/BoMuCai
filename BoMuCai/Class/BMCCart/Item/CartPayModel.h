//
//  CartPayModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/15.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCAddressModel.h"

@interface CartPayModel : NSObject

@property (nonatomic, copy) NSString *payMoney;

@property (nonatomic, strong) NSMutableArray *shopModels;

@property (nonatomic, assign) NSInteger buyNum;

@property (nonatomic, strong) PCAddressModel *addressModel;

@end
