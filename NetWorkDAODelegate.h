//
//  NetWorkDAODelegate.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/23.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkDAODelegate <NSObject>
@optional
-(void)getDetailSuccessWithArray:(NSArray *)detailArray;
-(void)uploadDataSuccess:(NSDictionary *)returnDic;

@end
