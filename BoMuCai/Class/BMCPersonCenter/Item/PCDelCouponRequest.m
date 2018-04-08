//
//  PCDelCouponRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/5/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCDelCouponRequest.h"

@implementation PCDelCouponRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_DelCoupon;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}

@end
