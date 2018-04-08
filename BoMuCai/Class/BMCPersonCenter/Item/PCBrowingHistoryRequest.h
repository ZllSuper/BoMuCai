//
//  PCBrowingHistoryRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface PCBrowingHistoryRequest : BaseMainRequest

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *pageSize;

@property (nonatomic, copy) NSString *curPage;

@end
