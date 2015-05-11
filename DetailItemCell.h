//
//  DetailItemCell.h
//  mapPicture
//
//  Created by liuyunxuan on 15/2/1.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DetailItemFrame.h"

@interface DetailItemCell : UITableViewCell
@property (nonatomic,weak)UIImageView *icon_View;
@property (nonatomic,weak)UILabel *address_Lable;
@property (nonatomic,weak)UIImageView *main_View;
@property (nonatomic,weak)UILabel *detail_Label;
@property(nonatomic,strong)DetailItemFrame *itemFrame;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
