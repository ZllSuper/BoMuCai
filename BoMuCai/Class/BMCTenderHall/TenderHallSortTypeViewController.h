//
//  TenderHallSortTypeViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenderSortTypeModel.h"

@class TenderHallSortTypeViewController;

@protocol TenderHallSortTypeViewControllerDelegate <NSObject>

- (void)typeVC:(TenderHallSortTypeViewController *)vc typeModel:(TenderSortTypeModel *)model;

@end

@interface TenderHallSortTypeViewController : UIViewController

@property (nonatomic, weak) id <TenderHallSortTypeViewControllerDelegate>delegate;

@end
