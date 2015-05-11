//
//  MPTabBar.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPTabBar.h"
#import "MPTabBarButton.h"

@interface MPTabBar()
@property (strong, nonatomic) NSMutableArray *tabBarButtons;
@property (weak, nonatomic) MPTabBarButton *selectedButton;
@property (weak, nonatomic) UIButton *plusButton;

@end

@implementation MPTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background_os7"]];
    [self addPlusBtn];
    return self;
}
- (void)addPlusBtn
{
    // 1.创建按钮
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 2.设置背景图片
    UIImage *bg = [UIImage imageNamed:@"tabbar_compose_button_os7"];
    [plusButton setBackgroundImage:bg forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
    
    // 3.设置顶部的+号图片
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
    
    // 4.监听按钮点击
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}
- (void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    MPTabBarButton *button = [[MPTabBarButton alloc] init];
    
    // 2.传递模型数据
    button.item = item;
    
    // 3.添加按钮
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    // 4.默认选中
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}
/**
 *  监听MPTabBarButton点击
 *
 *  @param button 被点击的tabbarButton
 */
- (void)buttonClick:(MPTabBarButton *)button
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 1.控制器选中按钮
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.4个按钮
    CGFloat buttonW = self.frame.size.width / 3;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        MPTabBarButton *button = self.tabBarButtons[index];
        button.tag = index;
        CGFloat buttonX = index * buttonW;
        if (index >= 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
    
    // 2.中间的+按钮
    self.plusButton.bounds = (CGRect){CGPointZero, self.plusButton.currentBackgroundImage.size};
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
