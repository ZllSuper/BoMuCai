//
//  GoodsSearchRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface GoodsSearchRequest : BaseMainRequest

@property (nonatomic, copy) NSString *searchName; //搜索文字

@property (nonatomic, copy) NSString *city; //市

@property (nonatomic, copy) NSString *curPage; //	页码

@property (nonatomic, copy) NSString *pageSize; //	分页多少条

@property (nonatomic, copy) NSString *sortAccording; //	排序（ASC 升序， DESC 降序）多个排序用逗号分隔  该字段为空，则按创建时间倒序排列 buyNum DESC, starLevel DESC,unitPrice ASC DESC

@property (nonatomic, copy) NSString *type; //分类Id

@property (nonatomic, copy) NSString *shopId; //店铺id

@end
