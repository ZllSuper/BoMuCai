//
//  BXHAddressViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXHAddressContainerController.h"
#import "BXHProModel.h"

@class BXHAddressViewController;

@protocol BXHAddressViewControllerDelegate <NSObject>

- (void)addressViewController:(BXHAddressViewController *)vc proModel:(BXHProModel *)proModel cityModel:(BXHCityModel *)cityModel areaModel:(BXHAreaModel *)areaModel;

@end

@interface BXHAddressViewController : UIViewController

@property (nonatomic, weak) id <BXHAddressViewControllerDelegate>delegate;

@end
