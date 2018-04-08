//
//  PCOrderDetailReasonCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailReasonCell.h"

@implementation PCOrderDetailReasonCell

+ (CGFloat)cellHeightWithStr:(NSString *)str
{
    CGFloat height = [str size_With_Font:Font_sys_12 constrainedToSize:CGSizeMake(DEF_SCREENWIDTH - 32, MAXFLOAT)].height;
    return height + 45;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
