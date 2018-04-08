//
//  WaresAllCommentRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/7/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface WaresAllCommentRequest : BaseMainRequest

@property (nonatomic, copy) NSString *curPage; // 页码

@property (nonatomic, copy) NSString *pageSize; // 分页多少条

@property (nonatomic, copy) NSString *waresId;// 商品ID

@end
