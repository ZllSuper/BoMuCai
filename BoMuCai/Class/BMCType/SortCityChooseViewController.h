//
//  SortCityChooseViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/20.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHCityModel.h"
#import "BXHProModel.h"

@class SortCityChooseViewController;

@protocol SortCityChooseViewControllerDelegate <NSObject>

- (void)chooseVc:(SortCityChooseViewController *)vc chooseCityModel:(BXHCityModel *)cityModel;

@end

@interface SortCityChooseViewController : UIViewController

@property (nonatomic, weak) id <SortCityChooseViewControllerDelegate>delegate;

- (instancetype)initWithAreaProModel:(BXHProModel *)proModel;

@end
