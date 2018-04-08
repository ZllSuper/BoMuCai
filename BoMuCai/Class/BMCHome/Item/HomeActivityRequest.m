//
//  HomeActivityRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "HomeActivityRequest.h"

@implementation HomeActivityRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.relativeUrlString = KURL_HomeActivity;
    if (!StringIsEmpty(self.shopId)) {
        self.reuqestBody = @{@"curPage":self.curPage, @"pageSize":self.pageSize, @"id":self.shopId, @"type":self.type};
    }
    else {
        self.reuqestBody = @{@"curPage":self.curPage, @"pageSize":self.pageSize, @"type":self.type};
    }
    self.method = BXHRequestMethodPost;
}


@end
