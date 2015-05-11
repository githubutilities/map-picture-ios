//
//  MPItemTool.h
//  mapPicture
//
//  Created by liuyunxuan on 15/2/2.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPItemToolDelegate.h"
@interface MPItemTool : NSObject
@property (weak,nonatomic)id<MPItemToolDelegate>delegate;

//+(void)postWithString:(NSString *)string success:(void(^)(NSArray *itemArray))success failure:(void(^)(NSError *error))failure;
//+(void)itemsBeginWithParam:(NSString *)string;
-(void)itemsBeginWithParam:(NSString *)string;
-(void)loadMoreWithCoordinate:(NSString *)coordinate;

@end
