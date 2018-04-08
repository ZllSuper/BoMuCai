//
//  CarSectionHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarShopModel.h"

@class CarSectionHeaderView;

@protocol CarSectionHeaderViewDelegate <NSObject>

- (void)headerViewDidSelectAction:(CarSectionHeaderView *)headerView;

@end

@interface CarSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, weak) id <CarSectionHeaderViewDelegate>delegate;

@property (nonatomic, weak) CarShopModel *weakModel;

@end
