//
//  PopContainerController.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/19.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "PopContainerController.h"

@implementation UIViewController(PopContainer)

static char PopContainerControllerKey;

- (void)setContainerController:(PopContainerController *)containerController
{
    objc_setAssociatedObject(self, &PopContainerControllerKey, containerController, OBJC_ASSOCIATION_ASSIGN);
}

- (PopContainerController *)containerController
{
    return objc_getAssociatedObject(self, &PopContainerControllerKey);
}


@end

@interface PopContainerController ()

@property (nonatomic, strong) UIViewController *rootViewController;

@property (nonatomic, strong) MASConstraint *rootLeft;

@end

@implementation PopContainerController

- (instancetype)initWithRootViewContorller:(UIViewController *)rootController
{
    if (self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.rootViewController = rootController;
        
        [self.view addSubview:self.rootViewController.view];
        [self addChildViewController:self.rootViewController];
        
        self.rootViewController.containerController = self;
        [self.rootViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.width.mas_equalTo(DEF_SCREENWIDTH * 0.8);
            make.bottom.mas_equalTo(self.view);
            self.rootLeft = make.left.mas_equalTo(self.view).offset(DEF_SCREENWIDTH);
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.rootLeft.offset(DEF_SCREENWIDTH * 0.2);
        [weakSelf.view layoutIfNeeded];
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ((self.rootViewController.view.left == DEF_SCREENWIDTH * 0.2) && !CGRectContainsPoint(self.rootViewController.view.frame, point))
    {
        [self dismissAnimate];
    }
}

- (void)dismissAnimate
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.rootLeft.offset(DEF_SCREENWIDTH);
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished)
        {
            [weakSelf.rootViewController.view removeAllSubviews];
            [weakSelf.rootViewController removeAllChildViewController];
            [weakSelf.rootViewController.view removeFromSuperview];
            [weakSelf.rootViewController removeFromParentViewController];
            weakSelf.rootViewController = nil;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
