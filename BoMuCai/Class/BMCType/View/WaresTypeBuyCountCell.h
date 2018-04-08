//
//  WaresTypeBuyCountCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/14.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCountView.h"

@class WaresTypeBuyCountCell;
@protocol WaresTypeBuyCountCellDelegate <NSObject>

- (void)buyCountCell:(WaresTypeBuyCountCell *)cell buyCountText:(NSString *)buyCount;

@end

@interface WaresTypeBuyCountCell : UICollectionViewCell <UITextFieldDelegate>

@property (nonatomic, strong) BuyCountView *buyView;

@property (nonatomic, weak) id <WaresTypeBuyCountCellDelegate>delegate;

+ (CGSize)sizeWithCell;

@end
