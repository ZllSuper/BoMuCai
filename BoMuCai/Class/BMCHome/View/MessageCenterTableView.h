//
//  MessageCenterTableView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BaseTableView.h"

#import "MessageCenterHeaderView.h"
#import "MessageCenterTalkCell.h"

@interface MessageCenterTableView : BaseTableView <EMChatManagerDelegate,EMGroupManagerDelegate>

@property (nonatomic, strong) MessageCenterHeaderView *headerView;

@end
