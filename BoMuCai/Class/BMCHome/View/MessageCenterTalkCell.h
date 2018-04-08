//
//  MessageCenterTalkCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBadgeView.h"
#import "BXHCornerRadiusImageView.h"
#import "ShopNameHeadRequest.h"

@interface MessageCenterTalkCell : UITableViewCell

@property (nonatomic, strong) BXHCornerRadiusImageView *headerImageView;

@property (nonatomic, strong) JSBadgeView *badgeView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) ShopNameHeadRequest *request;


- (void)requestWithConversationModel:(EaseConversationModel *)model;

@end
