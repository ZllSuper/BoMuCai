//
//  WaresDetailItemCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaresDetailItem.h"


@class WaresDetailItemCell;

@protocol WaresDetailItemCellDelegate <NSObject>

- (void)itemCell:(WaresDetailItemCell *)cell actionItem:(WaresDetailItem *)item;

@end

@interface WaresDetailItemCell : UITableViewCell

@property (nonatomic, strong) WaresDetailItem *leftItem;

@property (nonatomic, strong) WaresDetailItem *rightItem;

@property (nonatomic, weak) id <WaresDetailItemCellDelegate>delegate;

+ (CGFloat)showHeight;

@end
