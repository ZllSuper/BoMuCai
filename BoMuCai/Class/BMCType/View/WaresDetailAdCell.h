//
//  WaresDetailAdCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAdView.h"

@interface WaresDetailAdCell : UITableViewCell

@property (nonatomic, strong) DTAdView *adView;

+ (CGFloat)showHeight;

@end
