//
//  BXHRefreshFooter.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/12.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshBackFooter.h"
#import "BXHClockView.h"

@interface BXHRefreshFooter : MJRefreshBackFooter

@property (nonatomic, strong) BXHClockView *clockView;

@end
