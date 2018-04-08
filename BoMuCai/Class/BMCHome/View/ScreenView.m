//
//  ScreenView.m
//  ECar
//
//  Created by 步晓虎 on 14-12-17.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "ScreenView.h"

@interface ScreenViewItem ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) NSMutableDictionary *imageDict;

@end

@implementation ScreenViewItem

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.imageDict = [NSMutableDictionary dictionary];
        self.titleLabel.text = title;
        _itemState = ScreenViewItemStatueNormal;
    }
    return self;
}

- (void)creatSubViewTitle
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

- (void)creatSubViewSort
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(-4);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(8);
        make.left.mas_equalTo(self.titleLabel.mas_right);
    }];
    
}

- (void)setImage:(UIImage *)image withState:(ScreenViewItemStatue)statue
{
    if (statue == ScreenViewItemStatueNormal && self.itemState == ScreenViewItemStatueNormal)
    {
        self.rightImageView.image = image;
    }
    [self.imageDict setObject:image forKey:[self imageKey:statue]];
}

#pragma mark - get / set
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor getHexColorWithHexStr:@"#3f3f3f"];
        _titleLabel.font = Font_sys_14;
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}

- (void)setItemState:(ScreenViewItemStatue)itemState
{
    _itemState = itemState;
    switch (itemState)
    {
        case ScreenViewItemStatueNormal:
        {
            self.titleLabel.textColor = Color_MainText;
        }
            break;
        case ScreenViewItemStatueSelect:
        {
            self.titleLabel.textColor = Color_Main_Dark;
        }
            break;
        case ScreenViewItemStatueSelectAsc:
        {
            self.titleLabel.textColor = Color_Main_Dark;
        }
            break;
        case ScreenViewItemStatueSelectDsc:
        {
            self.titleLabel.textColor = Color_Main_Dark;
        }
            break;
        default:
        {
            self.titleLabel.textColor = Color_Main_Dark;
        }
            break;
    }
    
    if (self.type == ScreenViewItemSort)
    {
        NSString *imageKey = [self imageKey:itemState];
        UIImage *image = [self.imageDict objectForKey:imageKey];
        self.rightImageView.image = image;
    }
}

- (void)setType:(ScreenViewItemType)type
{
    _type = type;
    
    if (type == ScreenViewItemNormal || type == ScreenViewItemTouch)
    {
        [self creatSubViewTitle];
    }
    else
    {
        [self creatSubViewSort];
    }
}

- (NSString *)imageKey:(ScreenViewItemStatue)statue
{
    switch (statue)
    {
        case ScreenViewItemStatueNormal:
            return @"ScreenViewItemStatueNormal";
        case ScreenViewItemStatueSelect:
            return @"ScreenViewItemStatueSelect";
        case ScreenViewItemStatueSelectAsc:
            return @"ScreenViewItemStatueSelectAsc";
        case ScreenViewItemStatueSelectDsc:
            return @"ScreenViewItemStatueSelectDsc";
        default:
            return @"ScreenViewItemStatueNormal";
    }
}

@end


@interface ScreenView ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation ScreenView

- (instancetype)initWithScreenItems:(NSArray<ScreenViewItem *> *)items
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        self.items = items;
        
        ScreenViewItem *topItem = nil;
        for (ScreenViewItem *item in items)
        {
            NSInteger index = [items indexOfObject:item];
            [self addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                if (topItem)
                {
                    make.left.mas_equalTo(topItem.mas_right);
                    make.width.mas_equalTo(topItem);
                }
                else
                {
                    make.left.mas_equalTo(self);
                }
                
                if (index == items.count - 1)
                {
                    make.right.mas_equalTo(self);
                }
                
                make.top.mas_equalTo(self);
                make.bottom.mas_equalTo(self);
            }];
            topItem = item;
            [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:self.shadowView];
        [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setScreenItemTitle:(NSString *)title atIndex:(NSInteger)index
{
    ScreenViewItem *item = self.items[index];
    if (item)
    {
        item.titleLabel.text = title;
    }
    else
    {
        BXHLog(@"未发现Item");
    }
}

/**
 *  初始化所有的Item
 */
- (void)resetItem
{
    for (ScreenViewItem *item in self.items)
    {
        item.itemState = ScreenViewItemStatueNormal;
    }
}

- (void)selectItemAtIndex:(NSInteger)index
{
    ScreenViewItem *item = self.items[index];
    if (item.type == ScreenViewItemSort)
    {
        item.itemState = ScreenViewItemStatueSelectAsc;
    }
    else
    {
        item.itemState = ScreenViewItemStatueSelect;
    }
}

- (BOOL)checkItemSelect:(ScreenViewItem *)item
{
    return item.itemState != ScreenViewItemStatueNormal;
}

- (void)screenViewItemActionCallBack:(ScreenViewItem *)item
{
    if (self.delegate)
    {
        [self.delegate screenView:self screenItemAction:item index:[self.items indexOfObject:item]];
    }
}

#pragma mark - action
- (void)itemAction:(ScreenViewItem *)item
{
    if ([self checkItemSelect:item])
    {
        if (item.type == ScreenViewItemSort)
        {
            switch (item.itemState)
            {
                case ScreenViewItemStatueSelectAsc:
                {
                    item.itemState = ScreenViewItemStatueSelectDsc;
                }
                    break;
                    
                default:
                {
                    item.itemState = ScreenViewItemStatueSelectAsc;
                }
                    break;
            }
            [self screenViewItemActionCallBack:item];
        }
        return;
    }
    else
    {
        if (item.type == ScreenViewItemTouch)
        {
            
        }
        else if (item.type == ScreenViewItemSort)
        {
            [self resetItem];
            item.itemState = ScreenViewItemStatueSelectAsc;

        }
        else
        {
            [self resetItem];
            item.itemState = ScreenViewItemStatueSelect;
        }
        [self screenViewItemActionCallBack:item];
    }
}

#pragma mark - get
- (UIView *)shadowView
{
    if (!_shadowView)
    {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = Color_Gray_Line;
    }
    return _shadowView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
