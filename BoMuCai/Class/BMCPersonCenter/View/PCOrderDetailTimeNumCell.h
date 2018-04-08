//
//  PCOrderDetailTimeNumCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCOrderDetailTimeNumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirLabel;

+ (CGFloat)cellHeight;

@end
