//
//  MPTabBarController.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPTabBarController.h"
#import "MPTabBar.h"
#import "HomeMapViewController.h"
#import "PhotographyViewController.h"
#import "testViewConroller.h"
#import "UIImage+MP.h"
#import "IWNavigationController.h"
#import "IWComposeViewController.h"
#import "TWPhotoPickerController.h"


@interface MPTabBarController ()<MPTabBarDelegate>
@property(nonatomic,weak)MPTabBar *mpTabBar;

@end

@implementation MPTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    [self setupChildViewControllers];
    // Do any additional setup after loading the view.
}

-(void)setupTabBar
{
    MPTabBar *mpTabBar = [[MPTabBar alloc]init];
    //NSLog(@"tabBar frame:%@",NSStringFromCGRect(self.tabBar.frame));
    //NSLog(@"tabBar bounds:%@",NSStringFromCGRect(self.tabBar.bounds));
    mpTabBar.frame = self.tabBar.bounds;
    [mpTabBar setBackgroundColor:[UIColor whiteColor]];
    mpTabBar.delegate = self;
    [self.tabBar addSubview:mpTabBar];
    self.mpTabBar =mpTabBar;
    //NSLog(@"setupTabbar");
}
- (void)setupChildViewControllers
{
     //1.首页
//    HomeMapViewController *home = [[HomeMapViewController alloc] init];
//    home.tabBarItem.badgeValue = @"4";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"];
    [self setupChildViewController:nav title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];

    // 2.测试
    testViewConroller *test = [[testViewConroller alloc] init];
    test.tabBarItem.badgeValue = @"40";
    [self setupChildViewController:test title:@"测试" imageName:@"tabbar_profile_os7" selectedImageName:@"tabbar_profile_selected_os7"];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除之前的4个UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) { //UITabBarButton
            [child removeFromSuperview];
        }
    }
}


- (void)tabBar:(MPTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)tabBarDidClickedPlusButton:(MPTabBar *)tabBar
{
    TWPhotoPickerController *photoPicker = [[TWPhotoPickerController alloc]init];
    photoPicker.cropBlock = ^(UIImage *image) {
        NSLog(@"This is the image you choose %@",image);
        //do something
    };
    [self presentViewController:photoPicker animated:YES completion:^{
    }];
//    IWComposeViewController *compose = [[IWComposeViewController alloc] init];
//    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:compose];
//    [self presentViewController:nav animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置数据
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage originalImageWithName:selectedImageName];
    
    // 2.包装
    //    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:vc];
    //    [self addChildViewController:nav];
    
    // 3.添加按钮
    [self.mpTabBar addTabBarButtonWithItem:vc.tabBarItem];
}



@end
