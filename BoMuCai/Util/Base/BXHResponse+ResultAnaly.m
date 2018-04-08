//
//  BXHResponse+ResultAnaly.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/12/12.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "BXHResponse+ResultAnaly.h"

@implementation BXHResponse (ResultAnaly)

- (NSString *)code
{
    return self.responseObject[@"code"];
}

- (NSString *)message
{
    
    return self.responseObject[@"message"];
}

- (id)data
{
    return self.responseObject[@"data"];
}

@end
