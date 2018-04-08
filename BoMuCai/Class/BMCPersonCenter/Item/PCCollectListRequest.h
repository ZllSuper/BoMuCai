//
//  PCCollectListRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCCollectListRequest : BaseMainRequest

@property (nonatomic, copy) NSString *type; //	01900001:商品 01900003:店铺

@property (nonatomic, copy) NSString *userId;//	会员ID

@property (nonatomic, copy) NSString *curPage;//	页码

@property (nonatomic, copy) NSString *pageSize;//	分页多少条

@end
