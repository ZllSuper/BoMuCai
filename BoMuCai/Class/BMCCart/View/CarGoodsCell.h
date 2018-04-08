//
//  CarGoodsCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/4.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarBuyCountView.h"
#import "CarGoodModel.h"

@class CarGoodsCell;

@protocol CarGoodsCellDelegate <NSObject>

- (void)goodsCellSelect:(CarGoodsCell *)cell;

- (void)goodsCellCountAdd:(CarGoodsCell *)cell;

- (void)goodsCellCountReduce:(CarGoodsCell *)cell;

- (void)goodsCellTextFiledCountChange:(CarGoodsCell *)cell;

@end

@interface CarGoodsCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *goodsIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *statueLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet CarBuyCountView *buyCountView;

@property (weak, nonatomic) id <CarGoodsCellDelegate>delegate;

@property (weak, nonatomic) CarGoodModel *weakModel;

@end
