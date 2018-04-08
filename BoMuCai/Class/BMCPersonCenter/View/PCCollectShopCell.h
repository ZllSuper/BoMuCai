//
//  PCCollectShopCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/10.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCShopModel.h"

@interface PCCollectShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) BMCShopModel *weakModel;

@end
