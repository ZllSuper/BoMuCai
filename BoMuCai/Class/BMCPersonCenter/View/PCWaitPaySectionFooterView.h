//
//  PCWaitPaySectionFooterView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCOrderModel.h"

@class PCWaitPaySectionFooterView;

@protocol PCWaitPaySectionFooterViewDelegate <NSObject>

- (void)footerViewPhoneBtnAction:(PCWaitPaySectionFooterView *)footerView;

- (void)footerViewCancelBtnAction:(PCWaitPaySectionFooterView *)footerView;

- (void)footerViewRemindBtnAction:(PCWaitPaySectionFooterView *)footerView;

- (void)footerViewThirdBtnAction:(PCWaitPaySectionFooterView *)footerView;

@end

@interface PCWaitPaySectionFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *frePriceLabel;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UILabel *totalPriceLabel;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *frePriceSecLabel;

@property (nonatomic, strong) UIButton *phoneCallBtn;

@property (nonatomic, strong) UIButton *cancelOrderBtn;

@property (nonatomic, strong) UIButton *thirdBtn;

@property (nonatomic, strong) UIButton *remindBtn;

@property (nonatomic, weak) PCOrderModel *orderModel;

@property (nonatomic, weak) id <PCWaitPaySectionFooterViewDelegate>delegate;

@end
