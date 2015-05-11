//
//  MPItemCell.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPItemCell.h"
#import "MPItemFrame.h"
#import <UIImageView+WebCache.h>

// 昵称的字体
#define MPNameFont [UIFont systemFontOfSize:14]
// 正文的字体
#define MPTextFont [UIFont systemFontOfSize:15]

@interface MPItemCell()

@end

@implementation MPItemCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MPItemCell";
    MPItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MPItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        
        //5.分享 评论 赞
        UIButton *share_Button = [[UIButton alloc]init];
        [share_Button setTitle:@"分享" forState:UIControlStateNormal];
        [share_Button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.share_Button = share_Button;
        [self.contentView addSubview:share_Button];
        
        UIButton *reply_Button = [[UIButton alloc]init];
        [reply_Button setTitle:@"回复" forState:UIControlStateNormal];
        [reply_Button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.reply_Button = reply_Button;
        [self.contentView addSubview:reply_Button];

        UIButton *praise_Button = [[UIButton alloc]init];
        [praise_Button setTitle:@"赞" forState:UIControlStateNormal];
        [praise_Button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.contentView addSubview:praise_Button];
        self.praise_Button = praise_Button;
    }
    return self;
}
-(void)setItemFrame:(MPItemFrame *)itemFrame
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
    self.share_Button.frame = self.itemFrame.shareF;
    self.reply_Button.frame = self.itemFrame.replyF;
    self.praise_Button.frame = self.itemFrame.praiseF;
}



@end
