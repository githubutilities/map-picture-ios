//
//  MPCacheTool.h
//  mapPicture
//
//  Created by liuyunxuan on 15/2/1.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPItem.h"
@interface MPCacheTool : NSObject
+(void)addDic:(NSDictionary *)dic;
+(void)addDics:(NSArray *)dicArray;
+(void)deleteItems;
+(NSArray *)shareItems;
//extern int mpcacheABC;
@end
