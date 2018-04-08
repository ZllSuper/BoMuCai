//
//  SortProChooseViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHCityModel.h"

@class SortProChooseViewController;

@protocol SortProChooseViewControllerDelegate <NSObject>

- (void)chooseVc:(SortProChooseViewController *)vc chooseCityModel:(BXHCityModel *)cityModel;

@end

@interface SortProChooseViewController : UIViewController

@property (nonatomic, weak) id <SortProChooseViewControllerDelegate>delegate;

@end
