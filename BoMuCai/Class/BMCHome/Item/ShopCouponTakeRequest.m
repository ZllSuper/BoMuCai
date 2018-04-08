//
//  ShopCouponTakeRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopCouponTakeRequest.h"

@implementation ShopCouponTakeRequest

- (NSDictionary *)bxhReplaceKeyFormPropertyNames
{
    return @{@"shopId" : @"id"};
}

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_UserTakeCoupon;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
