//
//  BCPayModel.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/9/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCPayModel : NSObject

@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *noncestr;

@property (nonatomic, copy) NSString *package;

@property (nonatomic, copy) NSString *partnerid;

@property (nonatomic, copy) NSString *prepayid;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *sign;

@end
