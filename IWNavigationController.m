//
//  IWNavigationController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNavigationController.h"
#import "UIBarButtonItem+MP.h"

@interface IWNavigationController ()

@end

@implementation IWNavigationController

+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮的主题
    [self setupBarButtonTheme];

}

/**
 *  设置导航栏按钮的主题
 */
+ (void)setupBarButtonTheme
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 1.设置按钮的背景
        [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_os7"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed_os7"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable_os7"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    // 2.设置按钮的文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[UITextAttributeTextColor] = [UIColor colorWithRed:239 green:113 blue:0 alpha:1.0];
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[UITextAttributeFont] = [UIFont systemFontOfSize:15] ;
    [barItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[UITextAttributeTextColor] =[UIColor colorWithRed:208 green:208 blue:208 alpha:1.0];
;
    disableAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    [barItem setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 1.获得bar对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 3.设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[UITextAttributeTextColor] =[UIColor colorWithRed:200 green:200 blue:200 alpha:1.0];
    attrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];

    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    [navBar setTitleTextAttributes:attrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" higlightedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" higlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

/**
 *  更多
 */
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232 green:233 blue:232 alpha:1.0];
        // 重新拥有滑动出栈的功能
        self.interactivePopGestureRecognizer.delegate = nil;
}
@end
