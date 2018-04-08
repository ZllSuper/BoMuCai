//
//  STThirdPartBindRequest.h
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface STThirdPartBindRequest : BaseMainRequest

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *thirdType;

@end
