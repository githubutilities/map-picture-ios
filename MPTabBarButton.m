//
//  MPTabBarButton.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPTabBarButton.h"
#import "UIImage+MP.h"
#import "MPBadgeButton.h"
const double MPTabBarImageRatio = 0.65;


@interface MPTabBarButton()
@property (weak,nonatomic) MPBadgeButton *badgeButton;
@end

@implementation MPTabBarButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 2.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:236.0 green:103.0 blue:0 alpha:1] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage resizedImage:@"tabbar_slider_os7"] forState:UIControlStateSelected];
        //[self setupBadgeButton];
    }

    return self;
}
- (void)setupBadgeButton
{
    MPBadgeButton *badgeButton = [[MPBadgeButton alloc] init];
    badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:badgeButton];
    self.badgeButton = badgeButton;
}

/**
 *  目的是去掉父类在高亮时所做的操作
 */
- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * MPTabBarImageRatio;
    CGFloat titleH = contentRect.size.height - titleY;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleY, titleW,  titleH);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH = contentRect.size.height * MPTabBarImageRatio;
    CGFloat imageW = contentRect.size.width;
    return CGRectMake(0, 0, imageW,  imageH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 1.利用KVO监听item属性值的改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    // 2.属性赋值
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  KVO监听必须在监听器释放的时候，移除监听操作
 *  通知也得在释放的时候移除监听
 */
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

/**
 *  监听item的属性值改变
 *
 *  @param keyPath 哪个属性改变了
 *  @param object  哪个对象的属性改变了
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    
    // 设置提醒数字
    self.badgeButton.value = self.item.badgeValue;
    CGFloat badgeButtonX = self.frame.size.width - self.badgeButton.frame.size.width - 25;
    CGFloat badgeButtonY = 2;
    self.badgeButton.frame = CGRectMake(badgeButtonX, badgeButtonY, 10, 10);
}


@end

