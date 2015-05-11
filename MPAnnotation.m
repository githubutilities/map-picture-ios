//
//  MPAnnotation.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/25.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPAnnotation.h"

@implementation MPAnnotation

-(instancetype)initWithItem:(NSDictionary *)item
{
    if ([super init]) {
        CGFloat coordinateX = [[item valueForKey:@"coordinateX"]floatValue];
        CGFloat coordinateY = [[item valueForKey:@"coordinateY"]floatValue];
        self.coordinate = CLLocationCoordinate2DMake(coordinateX, coordinateY);
        self.title = [item valueForKey:@"detail"];
        self.url = [item valueForKey:@"url"];
    }
    return self;
}
@end
