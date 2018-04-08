//
//  PCAccountImageCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/8.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAccountImageCell.h"

@implementation PCAccountImageCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
