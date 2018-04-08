//
//  ShopSearchRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "ShopSearchRequest.h"

@implementation ShopSearchRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_ShopSearch;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;
}


@end
