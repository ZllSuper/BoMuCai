//
//  MyCartListRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "MyCartListRequest.h"

@implementation MyCartListRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_MyCartList;
    self.reuqestBody = [self bxhkeyValues];
    self.method = BXHRequestMethodPost;

}

@end
