//
//  ShopListCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCShopModel.h"

@interface ShopListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *vImageView;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *authImageView;

@property (weak, nonatomic) IBOutlet UILabel *heartCountLabel;

@property (weak, nonatomic) BMCShopModel *shopModel;

@end
