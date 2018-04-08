//
//  STWXTokenGetRequest.h
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//
#import "STWXBaseRequest.h"


@interface STWXTokenGetRequest : STWXBaseRequest

@property (nonatomic, copy) NSString *appid;

@property (nonatomic, copy) NSString *secret;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *grant_type;

@end
