//
//  MPTabBar.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPTabBar;

@protocol MPTabBarDelegate <NSObject>
@optional
- (void)tabBar:(MPTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
-(void)tabBarDidClickedPlusButton:(MPTabBar *)tabBar;
@end

@interface MPTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic , weak)id<MPTabBarDelegate>delegate;

@end
