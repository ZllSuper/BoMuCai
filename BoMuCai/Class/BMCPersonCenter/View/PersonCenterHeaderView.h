//
//  PersonCenterHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/6.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonCenterIconAndNameView.h"
#import "PersonCenterOrderStatueView.h"

@interface PersonCenterHeaderView : UIView

@property (nonatomic, strong) PersonCenterIconAndNameView *iconNameView;

@property (nonatomic, strong) PersonCenterOrderStatueView *statueView;

@end
