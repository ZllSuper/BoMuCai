//
//  PCOrderDetailBtnBottomView.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/2/7.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PCOrderDetailBtnBottomView.h"

@interface PCOrderDetailBtnBottomView()

@property (nonatomic, strong) NSMutableArray *btnAry;

@end

@implementation PCOrderDetailBtnBottomView

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init])
    {
        self.backgroundColor = Color_White;
        
        self.btnAry = [NSMutableArray array];
        
        UIView *topLine = [self lineView];
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        
        UIButton *topBtn = nil;
        for (NSString *title in titles)
        {
            BOOL end = ([titles indexOfObject:title] == (titles.count - 1));
            UIView *lineView = nil;
            UIButton *btn = [self creatBtnWithTitle:title];
            [self addSubview:btn];
            
            if (topBtn)
            {
                lineView = [self lineView];
                [self addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(topBtn.mas_right);
                    make.top.and.bottom.mas_equalTo(self);
                    make.width.mas_equalTo(1);
                }];
            }
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(1);
                make.bottom.mas_equalTo(self);
                if (lineView)
                {
                    make.left.mas_equalTo(lineView.mas_right);
                }
                else
                {
                    make.left.mas_equalTo(self);
                }
                if (topBtn)
                {
                    make.width.mas_equalTo(topBtn);
                }
                
                if(end)
                {
                    make.right.mas_equalTo(self);
                }
            }];
            
            [self.btnAry addObject:btn];
            topBtn = btn;
        }
    }
    return self;
}

- (void)btnAryResetWithTitles:(NSArray *)titles
{

    if (titles.count > self.btnAry.count)
    {
        NSInteger cha = titles.count - self.btnAry.count;
        for (int i =0; i < cha; i ++)
        {
            NSString *title = titles[i + self.btnAry.count];
            UIButton *btn = [self creatBtnWithTitle:title];
            [self.btnAry addObject:btn];
        }
    }
    else
    {
        NSInteger cha = self.btnAry.count - titles.count;
        for (int i = 0; i < cha; i ++)
        {
            [self.btnAry removeObjectAtIndex:titles.count + i];
        }
    }
}

- (void)reloadWithTitles:(NSArray *)titles
{
    [self removeAllSubviews];
    
    [self btnAryResetWithTitles:titles];
    
    UIView *topLine = [self lineView];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];

    UIButton *topBtn = nil;
    for (NSString *title in titles)
    {
        NSInteger index = [titles indexOfObject:title];
        BOOL end =  (index == (titles.count - 1));
        UIView *lineView = nil;
        UIButton *btn = self.btnAry[index];
        [btn setTitle:title forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (topBtn)
        {
            lineView = [self lineView];
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(topBtn.mas_right);
                make.top.and.bottom.mas_equalTo(self);
                make.width.mas_equalTo(1);
            }];
        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(1);
            make.bottom.mas_equalTo(self);
            if (lineView)
            {
                make.left.mas_equalTo(lineView.mas_right);
            }
            else
            {
                make.left.mas_equalTo(self);
            }
            if (topBtn)
            {
                make.width.mas_equalTo(topBtn);
            }
            
            if(end)
            {
                make.right.mas_equalTo(self);
            }
        }];
        
        [self.btnAry addObject:btn];
        topBtn = btn;
    }
}

#pragma mark - action
- (void)btnAction:(UIButton *)sender
{
    [self.delegate bottomView:self btnActionAtIndex:[self.btnAry indexOfObject:sender]];
}

#pragma mark - get
- (UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Color_Gray_Line;
    return lineView;
}

- (UIButton *)creatBtnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:Color_MainText forState:UIControlStateNormal];
    btn.titleLabel.font = Font_sys_14;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
