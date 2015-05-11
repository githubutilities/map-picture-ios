//
//  MPItemFrame.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPItemFrame.h"
#import "MPItem.h"
#define padding 10
// 正文的字体
#define MPTextFont [UIFont systemFontOfSize:15]



@implementation MPItemFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)setItem:(MPItem *)item
{
    _item = item;
    
    // 1.头像
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2地理位置显示
//    CGFloat coordinatePointX = iconX+iconW+10;
//    CGFloat coordinatePointY = iconY;
//    CGFloat coordinateSize = [self sizeWithText: font:<#(UIFont *)#> maxSize:<#(CGSize)#>]
    
    // 3.主图
    
    CGFloat mainViewX = 0;
    CGFloat mainViewY = iconY+iconH;
    CGFloat mainViewW = [[UIScreen mainScreen]bounds].size.width;
    CGFloat mainViewH = mainViewW;
    _mainviewF = CGRectMake(mainViewX, mainViewY, mainViewW, mainViewH);
    
    // 4.正文
    
    CGFloat detailX = padding;
    CGFloat detailY = mainViewY + mainViewH;
    CGSize  detailSize = [self sizeWithText:self.item.detail font:MPTextFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _detailF = CGRectMake(detailX, detailY, detailSize.width, detailSize.height);
    
    // 5.分享 reply praise
    CGFloat widthForButton = 60;
    CGFloat heightForButton = 30;
    CGFloat yForButton = padding +detailY;
    CGFloat contentForButton = [[UIScreen mainScreen]bounds].size.width/3;
    
    CGFloat shareX = padding;
    CGFloat replyX = padding + contentForButton;
    CGFloat praiseX = padding + contentForButton*2;
    
    _shareF = CGRectMake(shareX, yForButton, widthForButton, heightForButton);
    _replyF = CGRectMake(replyX, yForButton, widthForButton, heightForButton);
    _praiseF = CGRectMake(praiseX, yForButton, widthForButton, heightForButton);
    
    
    
    // 6.总宽度
    _cellHeigt = detailY +detailSize.height + heightForButton +padding;

}

@end
