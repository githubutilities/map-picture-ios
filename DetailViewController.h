//
//  DetailViewController.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/30.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailItemCell.h"
#import "MPItem.h"
@interface DetailViewController : UIViewController
@property (strong,nonatomic)MPItem *item;
@end
