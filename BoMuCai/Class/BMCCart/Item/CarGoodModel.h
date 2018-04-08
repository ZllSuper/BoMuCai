//
//  CarGoodModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGoodModel : NSObject

@property (nonatomic, copy) NSString *waresId;

@property (nonatomic, copy) NSString *mdsePropertyId;

@property (nonatomic, copy) NSString *mdseName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *unitPrice;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *stock;

@property (nonatomic, strong) NSArray *typeDtos;

@property (nonatomic, copy) NSString *yunfei;

@property (nonatomic, assign) BOOL select;

+ (CarGoodModel *)copyWith:(CarGoodModel *)model;

- (NSString *)typeDtoToStr;

@end
