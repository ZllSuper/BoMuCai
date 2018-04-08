//
//  PCOrderHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCOrderModel.h"

@class PCOrderHeaderView;

@protocol PCOrderHeaderViewDelegate <NSObject>

- (void)headerViewDidSelectAction:(PCOrderHeaderView *)headerView;

@end

@interface PCOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong) UILabel *statueLabel;

@property (nonatomic, weak) PCOrderModel *orderModel;

@property (nonatomic, weak) id <PCOrderHeaderViewDelegate>delegate;


@end
