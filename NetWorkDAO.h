//
//  NetWorkDAO.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/23.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import "NetWorkDAODelegate.h"

@interface NetWorkDAO : NSObject

@property (nonatomic,weak)id<NetWorkDAODelegate>delegate;
-(void)getDetail:(NSString *)coordinate;
-(void)upLoadImage:(UIImage *)uploadImage uploadText:(NSString *)uploadText;
+(void)postWithParams:(NSString *)string success:(void(^)(NSArray *dicArray))success failure:(void(^)(NSError *error))failure;
@end
