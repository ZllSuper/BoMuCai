//
//  PCAddressManagerCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCAddressManagerCell.h"

@implementation PCAddressManagerCell

+ (CGFloat)cellHeightWithAddressDetail:(NSString *)address
{
    CGFloat height = [address size_With_Font:Font_sys_12 constrainedToSize:CGSizeMake(DEF_SCREENWIDTH - 32, MAXFLOAT)].height;
    return 85 + height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.backgroundColor = Color_Gray_Line;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)defaultBtnAction:(id)sender
{
    [self.delegate addressManagerCellDefaultBtnAction:self];
}

- (IBAction)delBtnAction:(id)sender
{
    [self.delegate addressManagerCellDelBtnAction:self];
}

- (IBAction)editBtnAction:(id)sender
{
    [self.delegate addressManagerCellEditBtnAction:self];
}

- (void)setWeakModel:(PCAddressModel *)weakModel
{
    _weakModel = weakModel;
    self.defaultBtn.selected = [weakModel.isDefault boolValue];
    self.nameLabel.text = weakModel.name;
    self.phoneLabel.text = weakModel.phone;
    self.addressLabel.text = [weakModel composeAddressStr];
}

@end
