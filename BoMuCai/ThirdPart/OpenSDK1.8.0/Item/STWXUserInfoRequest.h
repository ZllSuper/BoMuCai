//
//  STWXUserInfoRequest.h
//  STIntelligent
//
//  Created by 步晓虎 on 2017/8/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "STWXBaseRequest.h"

@interface STWXUserInfoRequest : STWXBaseRequest

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *openid;

@end
