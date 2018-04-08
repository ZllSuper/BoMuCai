//
//  ActivityHeaderView.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTimeDownView.h"
#import "ActivityMidTipView.h"

@interface ActivityHeaderView : UICollectionReusableView

@property (nonatomic, strong) ActivityTimeDownView *timeView;

@property (nonatomic, strong) ActivityMidTipView *tipView;

@property (nonatomic, strong) UIImageView *imageView;

+ (CGSize)sizeForHeader;

@end
