//
//  VerifyCodeRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface VerifyCodeRequest : BaseMainRequest

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *type; //0：注册 1：忘记密码

@end
