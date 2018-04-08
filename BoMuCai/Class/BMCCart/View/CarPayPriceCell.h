//
//  CarPayPriceCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/5.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarPayPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *couponPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *frePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *orginalPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

@end
