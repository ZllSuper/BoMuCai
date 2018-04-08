//
//  PCAddressAddTextFiledCell.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/9.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PCAddressAddTextFiledCell;

@protocol PCAddressAddTextFiledCellDelegate <NSObject>

- (void)addressTextFiledCellEndEditing:(PCAddressAddTextFiledCell *)cell;

@end

@interface PCAddressAddTextFiledCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputTextFiled;

@property (weak, nonatomic) id <PCAddressAddTextFiledCellDelegate>delegate;

@property (nonatomic, copy) NSString *propertyName;

@end
