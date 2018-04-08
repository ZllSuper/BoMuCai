//
//  HomeActivityCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCActivityModel.h"

@class HomeActivityCell;

@protocol HomeActivityCellDelegate <NSObject>

- (void)activityCell:(HomeActivityCell *)cell cellItemAction:(BMCActivityModel *)model;

@end

@interface HomeActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) id <HomeActivityCellDelegate>delegate;

@property (nonatomic, weak) BMCActivityModel *leftModel;

@property (nonatomic, weak) BMCActivityModel *rightModel;

@end
