//
//  PCAddressManagerCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCAddressModel.h"

@class PCAddressManagerCell;
@protocol PCAddressManagerCellDelegate <NSObject>

- (void)addressManagerCellDefaultBtnAction:(PCAddressManagerCell *)cell;

- (void)addressManagerCellEditBtnAction:(PCAddressManagerCell *)cell;

- (void)addressManagerCellDelBtnAction:(PCAddressManagerCell *)cell;

@end

@interface PCAddressManagerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) PCAddressModel *weakModel;

@property (weak, nonatomic) id <PCAddressManagerCellDelegate>delegate;

+ (CGFloat)cellHeightWithAddressDetail:(NSString *)address;

@end
