//
//  UIMyDatePicker.m
//  OpenAllTheWay
//
//  Created by 步晓虎 on 14-10-30.
//  Copyright (c) 2014年 步晓虎. All rights reserved.
//

#import "UIMyDatePicker.h"
#import "UIColor+BXHColor.h"

@interface UIMyDatePicker ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation UIMyDatePicker

- (instancetype)initWithDelegate:(id<UIMyDatePickerDelegate>)delegate andType:(BXHMyPickerViewType)pickerType
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.delegate = delegate;
        
        self.type = pickerType;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];

        
//        self.backgroundView = [[UIView alloc] init];
//        self.backgroundView.alpha = 0.3;
//        self.backgroundView.backgroundColor = [UIColor blackColor];
//        [self addSubview:self.backgroundView];
//        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
//        }];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.92 alpha:1.0];
        [self addSubview:self.contentView];
        
        if (self.type == BXHMyPickerViewMidType)
        {
            self.contentView.size = CGSizeMake(300, 260);
            self.contentView.bottom = 0;
            self.contentView.left = (DEF_SCREENWIDTH - 300) / 2;
        }
        else
        {
            self.contentView.size = CGSizeMake(DEF_SCREENWIDTH, 260);
            self.contentView.left = 0;
            self.contentView.top = DEF_SCREENHEIGHT;
        }
        
        
        UIToolbar *tool = [[UIToolbar alloc] init];
        tool.userInteractionEnabled = YES;
        tool.translucent = NO;
        tool.backgroundColor = Color_White;
        [self.contentView addSubview:tool];
        [tool mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(@44);
            make.top.mas_equalTo(self.contentView);
        }];

        self.datePicker = [[UIDatePicker alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.locale = locale;
        self.datePicker.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tool.mas_bottom);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
        
        UIButton *certain = [UIButton buttonWithType:UIButtonTypeCustom];
        [certain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        certain.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [certain setTitleColor:Color_Main_Light forState:UIControlStateNormal];
        [certain setTitle:@"完成" forState:UIControlStateNormal];
        certain.layer.cornerRadius = 3.f;
        [certain addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
        [tool addSubview:certain];
        [certain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(tool).offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.centerY.mas_equalTo(tool);
        }];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [cancel setTitleColor:[UIColor getHexColorWithHexStr:@"#898e96"] forState:UIControlStateNormal];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        cancel.layer.cornerRadius = 3.f;
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [tool addSubview:cancel];
        [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tool).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 30));
            make.centerY.mas_equalTo(tool);
        }];

    }
    return self;
}

- (void)certain
{
//    [self cancelDatePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDatePicker:tapedCancel:)])
    {
        [self.delegate myDatePicker:self tapedCancel:NO];
    }
}


- (void)cancel
{
//    [self cancelDatePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDatePicker:tapedCancel:)])
    {
        [self.delegate myDatePicker:self tapedCancel:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self cancelDatePickerView];
}


#pragma mark - animate
- (void)showDatePickerView
{
    if (self.superview)
    {
        return;
    }
   self.frame = DEF_SCREENBOUNDS;
   [[UIApplication sharedApplication].keyWindow addSubview:self];
//   self.backgroundView.alpha = 0;
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
   [UIView animateWithDuration:0.3 animations:^{
       if (self.type == BXHMyPickerViewMidType)
       {
           self.contentView.centerY = self.centerY;
       }
       else
       {
           self.contentView.top = DEF_SCREENHEIGHT - self.contentView.height;
       }
   } completion:^(BOOL finished) {
   }];
}


- (void)cancelDatePickerView
{
    if (self.superview)
    {
 
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.top = DEF_SCREENHEIGHT;
        } completion:^(BOOL finished) {
            if (finished == YES)
            {
                [self removeFromSuperview];
            }
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
