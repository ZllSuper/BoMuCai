//
//  CarOrderInputAddressView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAddressModel.h"

@interface CarOrderInputAddressView : UIControl

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *detailAddressLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) PCAddressModel *addressModel;

- (void)reloadAddressWithModel:(PCAddressModel *)addressModel;

@end
