//
//  SearchNavBar.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchNavBar;

@protocol SearchNavBarDelegate <NSObject>

@optional
- (void)navbarSearchTypeBtnAction:(SearchNavBar *)navbar;

- (void)navbarSearchAction:(SearchNavBar *)navbar;

@end

@interface SearchNavBar : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, weak) id <SearchNavBarDelegate>delegate;

@property (nonatomic, copy) NSString *type;

@end

