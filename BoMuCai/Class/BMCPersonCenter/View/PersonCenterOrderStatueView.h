//
//  PersonCenterOrderStatueView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatueControl : UIControl

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@interface PersonCenterOrderStatueView : UIView

@property (nonatomic, strong) OrderStatueControl *waitPayBtn;

@property (nonatomic, strong) OrderStatueControl *waitSendBtn;

@property (nonatomic, strong) OrderStatueControl *waitReceiveBtn;

@property (nonatomic, strong) OrderStatueControl *backGoodsBtn;

@property (nonatomic, strong) OrderStatueControl *allBtn;

@end
