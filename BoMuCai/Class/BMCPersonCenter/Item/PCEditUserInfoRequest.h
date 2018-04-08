//
//  PCEditUserInfoRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCEditUserInfoRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId;//	用户Id

@property (nonatomic, copy) NSString *phone;//	手机号

@property (nonatomic, copy) NSString *nickName;//	用户昵称

@property (nonatomic, copy) NSString *email;//	邮箱

@property (nonatomic, copy) NSString *companyName;//	公司名称

@property (nonatomic, copy) NSString *sex;//	性别

@property (nonatomic, copy) NSString *address;//	所在地区

@property (nonatomic, copy) NSString *qq;//	QQ号码

@end
