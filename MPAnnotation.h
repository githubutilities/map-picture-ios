//
//  MPAnnotation.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/25.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MPAnnotation : MAPointAnnotation

@property (nonatomic,strong)NSString *url;

-(instancetype)initWithItem:(NSDictionary *)item;
@end
