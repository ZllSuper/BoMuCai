//
//  WaresInfoCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/23.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaresInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *freightLabel;

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (CGFloat)showHeight;

@end
