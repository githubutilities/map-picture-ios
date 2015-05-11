//
//  MPItem.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/27.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPItem.h"
#import "NSObject+MJCoding.h"

@implementation MPItem
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _mainView_url = [dict valueForKey:@"url"];
        _icon_url = [dict valueForKey:@"url"];
        _coordinatex = [dict valueForKey:@"coordinateX"];
        _coordinatey = [dict valueForKey:@"coordinateY"];
        _detail = [dict valueForKey:@"detail"];
    }
    return self;
}
+(instancetype)itemWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
MJCodingImplementation
@end
