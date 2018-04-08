//
//  TenderHallSortViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenderHallSortModel.h"

@class TenderHallSortViewController;

@protocol TenderHallSortViewControllerDelegate <NSObject>

- (void)sortVc:(TenderHallSortViewController *)vc sortChoose:(TenderHallSortModel *)sortModel;

@end

@interface TenderHallSortViewController : UIViewController

@property (nonatomic, weak) id <TenderHallSortViewControllerDelegate>delegate;

- (instancetype) initWithSortModel:(TenderHallSortModel *)sortModel;

@end
