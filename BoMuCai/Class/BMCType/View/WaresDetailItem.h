//
//  WaresDetailItem.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCWaresRecommendModel.h"

@interface WaresDetailItem : UIControl

@property (weak, nonatomic) IBOutlet UILabel *waresNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *waresIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@property (weak, nonatomic) BMCWaresRecommendModel *weakModel;

@end
