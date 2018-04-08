//
//  PCChangePasswordRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCChangePasswordRequest : BaseMainRequest

@property (nonatomic, copy) NSString *phone; //账号

@property (nonatomic, copy) NSString *password;//	密码

@property (nonatomic, copy) NSString *passwordNew; //	新密码

@end
