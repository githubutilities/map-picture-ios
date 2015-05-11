//
//  MPItem.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPItem : NSObject
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,copy)NSString *mainView_url;
@property(nonatomic,copy)NSString *icon_url;
@property(nonatomic,copy)NSString *coordinatex;
@property(nonatomic,copy)NSString *coordinatey;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemWithDict:(NSDictionary *)dict;
@end
