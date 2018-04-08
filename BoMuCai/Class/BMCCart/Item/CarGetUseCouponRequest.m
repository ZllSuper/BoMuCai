//
//  CarGetUseCouponRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/4/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarGetUseCouponRequest.h"

@implementation CarGetUseCouponRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_CouponCanUseList;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
