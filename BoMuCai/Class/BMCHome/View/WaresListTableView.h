//
//  WaresListTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "WaresListCell.h"
#import "GoodsSearchRequest.h"

@interface WaresListTableView : BaseTableView

@property (nonatomic, copy) NSString *searchName; //搜索文字

@property (nonatomic, copy) NSString *city; //市

@property (nonatomic, copy) NSString *sortAccording;

@property (nonatomic, copy) NSString *type;

@end
