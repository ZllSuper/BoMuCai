//
//  BXHResponse+ResultAnaly.h
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/12/12.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import <BXHNetWorkSDK/BXHNetWorkSDK.h>

@interface BXHResponse (ResultAnaly)

@property (nonatomic, copy, readonly) NSString *code;

@property (nonatomic, copy, readonly) NSString *message;

@property (nonatomic, copy, readonly) id data;

@end
