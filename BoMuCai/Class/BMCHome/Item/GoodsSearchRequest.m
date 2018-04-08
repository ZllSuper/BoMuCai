//
//  GoodsSearchRequest.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "GoodsSearchRequest.h"

@implementation GoodsSearchRequest
- (void)serializeHTTPRequest
{
    [super serializeHTTPRequest];
    if (!StringIsEmpty(self.type) && StringIsEmpty(self.shopId))
    {
        self.relativeUrlString = KURL_GoodsTypeSearch;
        self.reuqestBody = @{@"city" : self.city, @"curPage" : self.curPage, @"pageSize" : self.pageSize, @"sortAccording" : self.sortAccording, @"type" : self.type};

    }
    else
    {
        self.relativeUrlString = KURL_GoodsSearch;

        if (StringIsEmpty(self.shopId))
        {
            self.reuqestBody = @{@"searchName" : self.searchName, @"city" : self.city, @"curPage" : self.curPage, @"pageSize" : self.pageSize, @"sortAccording" : self.sortAccording};
        }
        else
        {
            self.reuqestBody = @{@"curPage" : self.curPage, @"pageSize" : self.pageSize, @"sortAccording" : self.sortAccording,@"shopId" : self.shopId,  @"type" : self.type};
            
        }

        
    }
    self.method = BXHRequestMethodPost;
}

@end
