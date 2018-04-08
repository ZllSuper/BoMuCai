//
//  ShopSearchRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface ShopSearchRequest : BaseMainRequest

@property (nonatomic, copy) NSString *searchName; //店铺名称

@property (nonatomic, copy) NSString *curPage;	//页码

@property (nonatomic, copy) NSString *pageSize;	//分页多少条

@end
