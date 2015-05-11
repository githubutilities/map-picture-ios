//
//  DetailItemCell.m
//  mapPicture
//
//  Created by liuyunxuan on 15/2/1.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "DetailItemCell.h"
#import <UIImageView+WebCache.h>
// 昵称的字体
#define MPNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define MPTextFont [UIFont systemFontOfSize:15]

@implementation DetailItemCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ItemID = @"DetailItemCell";
    DetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemID];
    if (cell == nil) {
        cell = [[DetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItemID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.icon_View = iconView;
        
        // 2.地址
        UILabel *address_Label = [[UILabel alloc] init];
        address_Label.font = MPNameFont;
        [self.contentView addSubview:address_Label];
        self.address_Lable = address_Label;
        
        
        // 3.正文
        UILabel *detail_Label = [[UILabel alloc] init];
        detail_Label.numberOfLines = 0;
        detail_Label.font = MPTextFont;
        [self.contentView addSubview:detail_Label];
        self.detail_Label= detail_Label;
        
        // 4.正图
        UIImageView *main_View = [[UIImageView alloc] init];
        self.main_View = main_View;
        [self.contentView addSubview:main_View];
        self.selectedBackgroundView = [[UIView alloc]init];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)setItemFrame:(DetailItemFrame *)itemFrame
{
    _itemFrame =itemFrame;
    [self settingData];
    [self settingFrame];
}
-(void)settingData
{
    MPItem *item = self.itemFrame.item;
    [self.icon_View sd_setImageWithURL:[NSURL URLWithString:item.icon_url] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.address_Lable.text = [NSString stringWithFormat:@"%@ %@",item.coordinatex,item.coordinatey];
    [self.main_View sd_setImageWithURL:[NSURL URLWithString:item.mainView_url] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.detail_Label.text = item.detail;
    
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)settingFrame
{
    self.icon_View.frame = self.itemFrame.iconF;
    self.main_View.frame = self.itemFrame.mainviewF;
    self.detail_Label.frame =self.itemFrame.detailF;
}

@end
