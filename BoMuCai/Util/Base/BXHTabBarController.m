//
//  BXHTabBarController.m
//  HangZhouSchool
//
//  Created by 步晓虎 on 16/6/1.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#import "BXHTabBarController.h"
#import "BXHBasicAnimation.h"
#import "UIView+AnimtateView.h"

@interface BXHTabBarController() <BXHTabBarDelegate>

@property (nonatomic, strong) BXHTabBar *myTabBar;

@property (nonatomic, strong) UIViewController *currentVc;

@property (nonatomic, strong) MASConstraint *animateConstraint;

@end

@implementation BXHTabBarController

- (instancetype) init
{
    if (self = [super init])
    {
        
        self.view.backgroundColor = [UIColor blackColor];
        self.myTabBar = [[BXHTabBar alloc] initWithFrame:CGRectZero];
        self.myTabBar.delelgate = self;
        [self tabBarItemCreat];
        [self.view addSubview:self.myTabBar];
        [self.myTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            self.animateConstraint = make.bottom.mas_equalTo(self.view).offset(0);
            make.height.mas_equalTo(TabBarHeight);
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)setTabBarHidden:(BOOL)hidden animate:(BOOL)animate
{
    CGFloat offset = hidden ? TabBarHeight : 0;
    self.animateConstraint.offset = offset;
    if (animate)
    {
        [UIView animateWithDuration:0.1 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else
    {
        [self.view layoutIfNeeded];
    }
}

- (void)setSelectControllerAtIndex:(NSInteger)index
{
    [self.tabBar setItemSelectAtIndex:index];
}

- (void)logOut
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    for (UINavigationController *navC in self.controllers)
    {
        [navC popToRootViewControllerAnimated:NO];
    }
    
    [self setSelectControllerAtIndex:0];
}

- (void)tabBarItemCreat
{
    BXHTabBarItem *item1 = [self itemCreatTitle:@"首页" normalImage:ImageWithName(@"TabBarNormal1") selectImage:ImageWithName(@"TabBarSel1")];
    BXHTabBarItem *item2 = [self itemCreatTitle:@"分类" normalImage:ImageWithName(@"TabBarNormal2") selectImage:ImageWithName(@"TabBarSel2")];
    BXHTabBarItem *item3 = [self itemCreatTitle:@"招标大厅" normalImage:ImageWithName(@"TabBarNormal3") selectImage:ImageWithName(@"TabBarSel3")];
    BXHTabBarItem *item4 = [self itemCreatTitle:@"购物车" normalImage:ImageWithName(@"TabBarNormal4") selectImage:ImageWithName(@"TabBarSel4")];
    BXHTabBarItem *item5 = [self itemCreatTitle:@"我的" normalImage:ImageWithName(@"TabBarNormal5") selectImage:ImageWithName(@"TabBarSel5")];

    self.tabBar.items = @[item1,item2,item3,item4,item5];
}

- (BXHTabBarItem *)itemCreatTitle:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage
{
    BXHTabBarItem *item = [[BXHTabBarItem alloc] init];
    item.titleText = title;
    [item setTextColor:Color_UnSelectText forState:NO];
    [item setTextColor:Color_Main_Dark forState:YES];
    [item setImage:normalImage forState:NO];
    [item setImage:selectImage forState:YES];
    return item;
}

#pragma mark - tabBarDelegate
- (BOOL)tabBar:(BXHTabBar *)tabBar selectItemAtIndex:(NSInteger)index
{    
    if (index == 0 || index == 1 || index == 2)
    {
        
    }
    else
    {
        if (![self checkIsLogin])
        {
            return NO;
        }
    }
    
    NSInteger fromIndex = [self.controllers indexOfObject:self.currentVc];
    UIViewController *showVc = self.controllers[index];
    
    if (![self.view.subviews containsObject:showVc.view])
    {
        [self addSubControllerView:showVc];
    }
    
    [self.currentVc.view.layer removeAllAnimations];
    [showVc.view.layer removeAllAnimations];
    
    [self view:self.currentVc.view show:NO fromLeft:fromIndex < index];
    [self view:showVc.view show:YES fromLeft:fromIndex > index];
    
    self.currentVc = showVc;
    
    return YES;
}

#define AnimateDur 0.3
- (void)view:(UIView *)animateView show:(BOOL)show fromLeft:(BOOL)fLeft
{
    
    if (show)
    {
        animateView.needRemoveFromSuperView = NO;
        if (fLeft)
        {
            CABasicAnimation *animate1 = [BXHBasicAnimation moveX:AnimateDur X:@0 fromx:[NSNumber numberWithFloat:-DEF_SCREENWIDTH]];
            CABasicAnimation *animate2 = [BXHBasicAnimation opacityForever_Animation:AnimateDur fromValue:@0 toValue:@1];
            CABasicAnimation *animate3 = [BXHBasicAnimation scale:@1.0 orgin:@0.5 durTimes:AnimateDur Rep:0];
            CAAnimationGroup *groupAnimate = [BXHBasicAnimation groupAnimation:@[animate1,animate2,animate3] durTimes:AnimateDur Rep:0];
            groupAnimate.delegate = animateView;
            [animateView.layer addAnimation:groupAnimate forKey:@"GroupAnimate"];
        }
        else
        {
            CABasicAnimation *animate1 = [BXHBasicAnimation moveX:AnimateDur X:@0 fromx:[NSNumber numberWithFloat:DEF_SCREENWIDTH]];
            CABasicAnimation *animate2 = [BXHBasicAnimation opacityForever_Animation:AnimateDur fromValue:@0 toValue:@1];
            CABasicAnimation *animate3 = [BXHBasicAnimation scale:@1.0 orgin:@0.5 durTimes:AnimateDur Rep:0];
            CAAnimationGroup *groupAnimate = [BXHBasicAnimation groupAnimation:@[animate1,animate2,animate3] durTimes:AnimateDur Rep:0];
            groupAnimate.delegate = animateView;
            [animateView.layer addAnimation:groupAnimate forKey:@"GroupAnimate"];
        }
    }
    else
    {
        animateView.needRemoveFromSuperView = YES;
        if (fLeft)
        {
            CABasicAnimation *animate1 = [BXHBasicAnimation moveX:AnimateDur X:[NSNumber numberWithFloat:-DEF_SCREENWIDTH] fromx:@0];
            CABasicAnimation *animate2 = [BXHBasicAnimation opacityForever_Animation:AnimateDur fromValue:@1 toValue:@0];
            CABasicAnimation *animate3 = [BXHBasicAnimation scale:@0.5 orgin:@1.0 durTimes:AnimateDur Rep:0];
            CAAnimationGroup *groupAnimate = [BXHBasicAnimation groupAnimation:@[animate1,animate2,animate3] durTimes:AnimateDur Rep:0];
            groupAnimate.delegate = animateView;
            [animateView.layer addAnimation:groupAnimate forKey:@"GroupAnimate"];
            
        }
        else
        {
            CABasicAnimation *animate1 = [BXHBasicAnimation moveX:AnimateDur X:[NSNumber numberWithFloat:DEF_SCREENWIDTH] fromx:@0];
            CABasicAnimation *animate2 = [BXHBasicAnimation opacityForever_Animation:AnimateDur fromValue:@1 toValue:@0];
            CABasicAnimation *animate3 = [BXHBasicAnimation scale:@0.5 orgin:@1.0 durTimes:AnimateDur Rep:0];
            CAAnimationGroup *groupAnimate = [BXHBasicAnimation groupAnimation:@[animate1,animate2,animate3] durTimes:AnimateDur Rep:0];
            groupAnimate.delegate = animateView;
            [animateView.layer addAnimation:groupAnimate forKey:@"GroupAnimate"];
        }
    }
}


- (void)addSubControllerView:(UIViewController *)subController
{
    [self.view insertSubview:subController.view belowSubview:self.myTabBar];
    [subController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.myTabBar.mas_top);
    }];
}

#pragma mark - get / set
- (BXHTabBar *)tabBar
{
    return self.myTabBar;
}


- (void)setControllers:(NSArray *)controllers
{
    for (UIViewController *controller in controllers)
    {
        if ([controllers indexOfObject:controller] == 0)
        {
            self.currentVc = controller;
            [self addSubControllerView:controller];
        }
       
        [self addChildViewController:controller];
    }
    _controllers = controllers;
}

@end
