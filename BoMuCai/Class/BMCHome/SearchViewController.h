//
//  SearchViewController.h
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@protocol SearchViewControllerDelegate <NSObject>

- (void)searchController:(SearchViewController *)searchController searchText:(NSString *)searchText type:(NSString *)type;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, weak) id <SearchViewControllerDelegate>delegate;

@end
