//
//  HomeActivityRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/16.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface HomeActivityRequest : BaseMainRequest

@property (nonatomic, copy) NSString *curPage;//	页码

@property (nonatomic, copy) NSString *pageSize;//	分页多少条

@property (nonatomic, copy) NSString *type;// 0商家活动 1系统活动

@property (nonatomic, copy) NSString *shopId;// 店铺id

@end
