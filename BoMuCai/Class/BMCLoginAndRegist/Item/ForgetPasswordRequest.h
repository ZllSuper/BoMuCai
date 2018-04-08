//
//  ForgetPasswordRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface ForgetPasswordRequest : BaseMainRequest

@property (nonatomic, copy) NSString *phone; //	手机号码

@property (nonatomic, copy) NSString *verificationCode; //	验证码

@property (nonatomic, copy) NSString *password;	//密码

@end
