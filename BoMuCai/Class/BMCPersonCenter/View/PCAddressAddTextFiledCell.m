//
//  PCAddressAddTextFiledCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressAddTextFiledCell.h"

@implementation PCAddressAddTextFiledCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputTextFiled.delegate = self;
    // Initialization code
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate addressTextFiledCellEndEditing:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
