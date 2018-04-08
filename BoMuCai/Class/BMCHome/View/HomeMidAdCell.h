//
//  HomeMidAdCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/17.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAdView.h"
#import "HomeAdModel.h"

@interface HomeMidAdCell : UITableViewCell

@property (nonatomic, strong) DTAdView *adView;

@property (nonatomic, strong) NSArray *adModelList;

@end
