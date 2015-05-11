//
//  MPBadgeButton.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPBadgeButton.h"
#import "UIImage+MP.h"

@implementation MPBadgeButton
@synthesize value = _value;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted { }

- (void)setValue:(NSString *)value
{
    _value = [value copy];
    
    // 1.设置可见性
    if (value.length) {
        self.hidden = NO;
        
        // 2.设置尺寸
        CGRect frame = self.frame;
        frame.size.height = self.currentBackgroundImage.size.height;
        if (value.length > 1) {
            CGSize valueSize = [value sizeWithFont:self.titleLabel.font];
            frame.size.width = valueSize.width + 10;
        } else {
            frame.size.width = self.currentBackgroundImage.size.width;
        }
        [super setFrame:frame];
        
        // 3.内容
        [self setTitle:value forState:UIControlStateNormal];
    } else {
        self.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size = self.bounds.size;
    [super setBounds:bounds];
}

@end
