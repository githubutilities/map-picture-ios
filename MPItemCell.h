//
//  MPItemCell.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPItem.h"
#import "MPItemFrame.h"

@interface MPItemCell : UITableViewCell
@property (nonatomic,weak)UIImageView *icon_View;
@property (nonatomic,weak)UILabel *address_Lable;
@property (nonatomic,weak)UIImageView *main_View;
@property (nonatomic,weak)UILabel *detail_Label;
@property (nonatomic,weak)UIButton *share_Button;
@property (nonatomic,weak)UIButton *reply_Button;
@property (nonatomic,weak)UIButton *praise_Button;
@property(nonatomic,strong)MPItemFrame *itemFrame;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
