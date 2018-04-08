//
//  TenderHallProViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/3.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHProModel.h"

@class TenderHallProViewController;

@protocol TenderHallProViewControllerDelegate <NSObject>

- (void)proVC:(TenderHallProViewController *)vc proModel:(BXHProModel *)proModel;

@end

@interface TenderHallProViewController : UIViewController

@property (nonatomic, weak) id <TenderHallProViewControllerDelegate>delegate;

@end
