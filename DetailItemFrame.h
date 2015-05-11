//
//  DetailItemFrame.h
//  mapPicture
//
//  Created by liuyunxuan on 15/2/1.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MPItem.h"
@interface DetailItemFrame : NSObject
@property (nonatomic,strong)MPItem *item;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect detailF;
@property (nonatomic, assign, readonly) CGRect mainviewF;
@property (nonatomic, assign, readonly) CGRect coordinateF;
@property (nonatomic, assign, readonly) CGFloat cellHeigt;

@end
