//
//  PCAddressManagerTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"
#import "PCAddressManagerCell.h"
#import "PCAddressModel.h"
#import "PCAddressListRequest.h"
#import "PCAddressSetDetaultRequest.h"
#import "PCDelAddressRequest.h"

@class PCAddressManagerTableView;
@protocol PCAddressManagerTableViewProtocol <NSObject>

- (void)tableVIew:(PCAddressManagerTableView *)tableView editCell:(PCAddressManagerCell *)cell;

@end

@interface PCAddressManagerTableView : BaseTableView <PCAddressManagerCellDelegate>

@property (nonatomic, weak) id <PCAddressManagerTableViewProtocol>protocol;

@end
