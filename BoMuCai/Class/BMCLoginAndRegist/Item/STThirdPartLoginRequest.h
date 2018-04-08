//
//  STThirdPartLoginRequest.h
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface STThirdPartLoginRequest : BaseMainRequest

@property (nonatomic, copy) NSString *thirdType; 

@property (nonatomic, copy) NSString *openId;

@end
