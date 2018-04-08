//
//  STThirdPartBindRequest.m
//  STIntelligent
//
//  Created by 步晓虎 on 2017/7/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "STThirdPartBindRequest.h"

@implementation STThirdPartBindRequest

- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    self.reuqestBody = [self bxhkeyValues];
    self.relativeUrlString = KURL_ThirdBind;
    self.method = BXHRequestMethodPost;
}


@end
