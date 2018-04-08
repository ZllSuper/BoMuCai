//
//  PCAccountInfoTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "PCAccountImageCell.h"
#import "PCAccountLabelCell.h"
#import "PCAccountModel.h"

#import "PCAccountInfoRequest.h"

@interface PCAccountInfoTableView : BaseTableView

@property (nonatomic, strong) PCAccountImageCell *imageCell;

@property (nonatomic, strong) PCAccountModel *accountModel;

@end
