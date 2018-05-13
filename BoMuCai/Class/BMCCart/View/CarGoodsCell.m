//
//  CarGoodsCell.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "CarGoodsCell.h"

NSNotificationName const CarGoodsCellEidtNotification = @"CarGoodsCellEidtNotification";
NSNotificationName const CarGoodsCellDoneNotification = @"CarGoodsCellDoneNotification";

@implementation CarGoodsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.buyCountView.hidden = YES;
    self.buyCountView.countTextFiled.delegate = self;
    [self.buyCountView.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCountView.reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCountView.countTextBtn addTarget:self action:@selector(countBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carGoodsCellEidtNotification) name:CarGoodsCellEidtNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carGoodsCellDoneNotification) name:CarGoodsCellDoneNotification object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CarGoodsCellEidtNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CarGoodsCellDoneNotification object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)addBtnAction
{
    [self.delegate goodsCellCountAdd:self];
}

- (void)reduceBtnAction
{
    [self.delegate goodsCellCountReduce:self];
}

- (void)countBtnAction
{
    [self.delegate goodsCellCount:self];
}

- (IBAction)cellSelectBtnAction:(id)sender
{
    [self.delegate goodsCellSelect:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate goodsCellTextFiledCountChange:self];
}

- (void)setWeakModel:(CarGoodModel *)weakModel
{
    _weakModel = weakModel;
    self.selectBtn.selected = weakModel.select;
    self.titleLabel.text = weakModel.mdseName;
    [self.goodsIconImageView sd_setImageWithURL:[NSURL encodeURLWithString:weakModel.image] placeholderImage:ImagePlaceHolder];
    self.moneyLabel.text = _StrFormate(@"￥%@",MoneyDeal(weakModel.unitPrice));
//    self.buyCountView.reduceBtn.enabled = YES;
//    self.buyCountView.addBtn.enabled = YES;
    if([weakModel.amount integerValue] >= [weakModel.stock integerValue])
    {
        weakModel.amount = weakModel.stock;
//        self.buyCountView.addBtn.enabled = NO;
    }
    
    if ([weakModel.stock integerValue] <= 1 || [weakModel.amount integerValue] <= 1)
    {
//        self.buyCountView.reduceBtn.enabled = NO;
    }
    
    self.statueLabel.hidden = [weakModel.stock integerValue] > 0;
    self.selectBtn.enabled = self.statueLabel.hidden;
    self.buyCountView.countTextFiled.text = weakModel.amount;
    self.buyCountLabel.text = weakModel.amount;
}

#pragma mark Notification
- (void)carGoodsCellEidtNotification
{
    self.buyCountView.hidden = NO;
    self.buyCountLabel.hidden = YES;
}

- (void)carGoodsCellDoneNotification
{
    self.buyCountView.hidden = YES;
    self.buyCountLabel.hidden = NO;
}

@end
