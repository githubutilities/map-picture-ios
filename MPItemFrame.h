//
//  MPItemFrame.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MPItem;


@interface MPItemFrame : NSObject
@property (nonatomic,strong)MPItem *item;

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect detailF;
@property (nonatomic, assign, readonly) CGRect mainviewF;
@property (nonatomic, assign, readonly) CGRect coordinateF;
@property (nonatomic, assign, readonly) CGFloat cellHeigt;
@property (nonatomic, assign, readonly) CGRect shareF;
@property (nonatomic, assign, readonly) CGRect replyF;
@property (nonatomic, assign, readonly) CGRect praiseF;

@end
