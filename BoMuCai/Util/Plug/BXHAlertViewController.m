//
//  BXHAlertViewController.m
//  GuoGangTong
//
//  Created by 步晓虎 on 2016/11/23.
//  Copyright © 2016年 woshishui. All rights reserved.
//

#import "BXHAlertViewController.h"

@interface BXHAlertAction ()

@property (copy, nonatomic) void(^actionHandler)(BXHAlertAction *action);

@end

@implementation BXHAlertAction

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(void (^)(BXHAlertAction *))handler
{
    BXHAlertAction *instance = [BXHAlertAction new];
    instance -> _title = title;
    instance -> _titleColor = titleColor;
    instance.actionHandler = handler;
    return instance;
}
@end

@interface BXHAlertViewController ()
{
    BOOL _firstDisplay;
    
    CGFloat _buttonHeight;
}

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray *mutableActions;

@property (strong, nonatomic) UIButton *backgroundView;

@property (strong, nonatomic) UIView *contentView;

@property (weak, nonatomic) UIView *weakSourceView;

@end

@implementation BXHAlertViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title type:(BXHAlertType)type
{
    
    BXHAlertViewController *instance = [[BXHAlertViewController alloc] init];
    instance.title = title;
    instance.alertType = type;
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self defaultSetting];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建对话框
    [self creatBackGroundView];
    
    [self creatContentView];
    
    if (self.alertType == BXHAlertMessageType)
    {
        self.weakSourceView = self.messageLabel;
        if (self.message.length > 0)
        {
            self.messageLabel.text = self.message;
        }
        
        if (self.attributeStr)
        {
            self.messageLabel.attributedText = self.attributeStr;
        }

    }
    else
    {
        self.weakSourceView = self.sourceView;
    }
    
    [self.contentView addSubview:self.weakSourceView];
    [self.weakSourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
    }];

    [self creatAllButtons];
    
    [self creatAllSeparatorLine];
    
    //更新分割线的frame
    [self updateAllSeparatorLineFrame];
    //更新按钮的frame
    [self updateAllButtonsFrame];
    
    self.titleLabel.text = self.title;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor clearColor];
    

    //显示弹出动画
//    [self showAppearAnimation];
    
}

- (void)defaultSetting
{
    _buttonHeight = 45;
    _firstDisplay = YES;
    _messageAlignment = NSTextAlignmentCenter;
}

#pragma mark - 创建内部视图

- (void)creatBackGroundView
{
    self.backgroundView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.3;
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

//内容层
- (void)creatContentView
{
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = Color_White;
    self.contentView.layer.cornerRadius = 8;
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.borderColor = Color_Gray_Line.CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.alpha = 1;
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).offset(-40);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(@260);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(5);
        make.right.mas_equalTo(self.contentView).offset(-5);
        make.top.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(@17);
    }];

}

//创建所有按钮
- (void)creatAllButtons
{
    for (int i=0; i<self.actions.count; i++)
    {
        BXHAlertAction *action = self.actions[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:Color_Main_Light forState:UIControlStateNormal];
        [btn setTitle:action.title forState:UIControlStateNormal];
        [btn setTitleColor:action.titleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}

//创建所有的分割线
- (void)creatAllSeparatorLine
{
    if (!self.actions.count)
    {
        return;
    }
    
    //要创建的分割线条数
    NSInteger linesAmount = self.actions.count;
    for (int i=0; i<linesAmount; i++)
    {
        UIView *separatorLine = [UIView new];
        separatorLine.tag = 1000+i;
        separatorLine.backgroundColor = Color_Gray_Line;
        [self.contentView addSubview:separatorLine];
    }
}

- (void)updateAllSeparatorLineFrame
{
    //割线的条数
    NSInteger linesAmount = self.actions.count;
    
    if (!linesAmount)
    {
        return;
    }
    UIView *separatorLine = [_contentView viewWithTag:1000];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weakSourceView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@1);
    }];
}


- (void)updateAllButtonsFrame
{
    
    NSInteger count = self.actions.count;
    
    if (!count)
    {
        return;
    }
    
    if (count > 2)
    {
        UIButton *topBtn;
        for (int i = 0; i < count; i ++)
        {
            UIButton *btn = [self.contentView viewWithTag:10 + i];
            UIView *separatorLine = [self.contentView viewWithTag:1000 + i];
            if (topBtn)
            {
                [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.contentView);
                    make.right.mas_equalTo(self.contentView);
                    make.height.mas_equalTo(@1);
                    make.top.mas_equalTo(topBtn.mas_bottom);
                }];
            }
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView);
                make.height.mas_equalTo(@40);
                make.top.mas_equalTo(separatorLine.mas_bottom);
                if (i == (count - 1))
                {
                    make.bottom.mas_equalTo(self.contentView);
                }
            }];
            
            topBtn = btn;
        }
    }
    else
    {
        UIButton *btn = [self.contentView viewWithTag:10];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.weakSourceView.mas_bottom).offset(21);
            make.left.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(@40);
            if (count == 1)
            {
                make.right.mas_equalTo(self.contentView);
            }
        }];
        
        if (count > 1)
        {
            UIView *separatorLine = [self.contentView viewWithTag:1001];
            [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btn).offset(5);
                make.left.mas_equalTo(btn.mas_right);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(btn).offset(-5);
            }];
            
            UIButton *btn2 = [self.contentView viewWithTag:10 + 1];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.weakSourceView.mas_bottom).offset(21);
                make.left.mas_equalTo(separatorLine.mas_right);
                make.bottom.mas_equalTo(self.contentView);
                make.height.mas_equalTo(@40);
                make.right.mas_equalTo(self.contentView);
                make.width.mas_equalTo(btn);
            }];
        }

    }
}


#pragma mark - 事件响应
- (void)didClickButton:(UIButton *)sender
{
    BXHAlertAction *action = self.actions[sender.tag-10];
    if (action.actionHandler) {
        action.actionHandler(action);
    }
    
    [self showDisappearAnimation];
}

#pragma mark - 其他方法

- (void)addAction:(BXHAlertAction *)action
{
    [self.mutableActions addObject:action];
}

- (UILabel *)creatLabelWithFontSize:(CGFloat)fontSize {
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = Color_MainText;
    return label;
}

- (void)showAppearAnimation
{
    
    if (_firstDisplay)
    {
        _firstDisplay = NO;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.backgroundView.alpha = 0.3;
            self.contentView.alpha = 1;
        } completion:nil];
    }
}

- (void)showDisappearAnimation
{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundView.alpha = 0;
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - getter & setter

- (NSString *)title
{
    return [super title];
}

- (NSArray<BXHAlertAction *> *)actions
{
    return [NSArray arrayWithArray:self.mutableActions];
}

- (NSMutableArray *)mutableActions
{
    if (!_mutableActions)
    {
        _mutableActions = [NSMutableArray array];
    }
    return _mutableActions;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [self creatLabelWithFontSize:16];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel)
    {
        _messageLabel = [self creatLabelWithFontSize:14];
        _messageLabel.textAlignment = self.messageAlignment;
    }
    return _messageLabel;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

- (void)setAttributeStr:(NSAttributedString *)attributeStr
{
    _attributeStr = attributeStr;
    self.messageLabel.attributedText = attributeStr;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment
{
    _messageAlignment = messageAlignment;
    self.messageLabel.textAlignment = messageAlignment;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
