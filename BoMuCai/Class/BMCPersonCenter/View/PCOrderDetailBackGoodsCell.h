//
//  PCOrderDetailBackGoodsCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCOrderDetailBackGoodsCell;

@protocol PCOrderDetailBackGoodsCellDelegate <NSObject>

- (void)backGoodsActionCell:(PCOrderDetailBackGoodsCell *)cell;

@end

@interface PCOrderDetailBackGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *backGoodsBtn;

@property (nonatomic, weak) id <PCOrderDetailBackGoodsCellDelegate>delegate;

+ (CGFloat)cellHeight;

@end
