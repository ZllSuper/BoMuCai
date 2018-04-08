//
//  WaresDetailRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <BXHNetWorkSDK/BXHNetWorkSDK.h>
#import "BaseMainRequest.h"

@interface WaresDetailRequest : BaseMainRequest

@property (nonatomic, copy) NSString *waresId;

@property (nonatomic, copy) NSString *userId;

@end
