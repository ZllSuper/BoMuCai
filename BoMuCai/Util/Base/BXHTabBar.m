//
//  BXHTabBar.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/1.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "BXHTabBar.h"

@interface BXHTabBarItem()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableDictionary *valueDict;

@end

#define SelectImageKey @"SelectImageKey"
#define UnSelectImageKey @"UnSelectImageKey"
#define SelectTextColorKey @"SelectTextColorKey"
#define UnSelectTextColorKey @"UnSelectTextColorKey"

@implementation BXHTabBarItem

- (instancetype) init
{
    if (self = [super init])
    {
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(7.5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-3);
        }];
        
        self.valueDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setTextColor:(UIColor *)color forState:(BOOL)selected
{
    [self.valueDict setObject:color forKey:selected ? SelectTextColorKey : UnSelectTextColorKey];
}

- (void)setImage:(UIImage *)image forState:(BOOL)selected
{
    [self.valueDict setObject:image forKey:selected ? SelectImageKey : UnSelectImageKey];
}

- (void)setSelected:(BOOL)selected
{
    self.imageView.image = self.valueDict[selected ? SelectImageKey : UnSelectImageKey];
    self.titleLabel.textColor = self.valueDict[selected ? SelectTextColorKey : UnSelectTextColorKey];
    [super setSelected:selected];
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = _titleText;
}

@end

@implementation BXHTabBar

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor getHexColorWithHexStr:@"#f9f9f9"];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = Color_Gray_Line;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setItems:(NSArray<BXHTabBarItem *> *)items
{
    CGFloat itemWidth = (DEF_SCREENWIDTH - ItemGap * (items.count + 1)) / items.count;
    for (BXHTabBarItem *item in items)
    {
        NSInteger index = [items indexOfObject:item];
        item.selected = index == 0;
        item.frame = CGRectMake(index * (itemWidth + ItemGap) + ItemGap, 0, itemWidth, TabBarHeight);
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
    _items = items;
}

- (void)setItemSelectAtIndex:(NSInteger)index
{
    BXHTabBarItem *item = self.items[index];
    [item sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)itemAction:(BXHTabBarItem *)item
{
    if (item.selected) return;
    self.selectIndex = [self.items indexOfObject:item];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    
    if (self.delelgate)
    {
       BOOL canSelect = [self.delelgate tabBar:self selectItemAtIndex:selectIndex];
        if (canSelect)
        {
            for (BXHTabBarItem *allItem in self.items)
            {
                allItem.selected = NO;
            }
            BXHTabBarItem *item = self.items[selectIndex];
            item.selected = YES;
            _selectIndex = selectIndex;

        }
    }
}

@end
