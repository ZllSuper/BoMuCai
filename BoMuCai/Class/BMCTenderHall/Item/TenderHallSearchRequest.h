//
//  TenderHallSearchRequest.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/21.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseMainRequest.h"

@interface TenderHallSearchRequest : BaseMainRequest

@property (nonatomic, copy) NSString *curPage; //当前页码

@property (nonatomic, copy) NSString *pageSize;	//每页信息条数

@property (nonatomic, copy) NSString *startStamp;	//筛选中的起始日期时间戳

@property (nonatomic, copy) NSString *endStamp;//	筛选中的结束日期时间戳

@property (nonatomic, copy) NSString *typeId;//	分类Id

@property (nonatomic, copy) NSString *tenderStatus; //	招标状态;00700001:进行中\00700002:已结束
@property (nonatomic, copy) NSString *address; //	地区（辽宁；北京；山东）

@property (nonatomic, copy) NSString *nameLike; //关键字

@end
