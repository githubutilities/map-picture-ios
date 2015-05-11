//
//  MPItemToolDelegate.h
//  mapPicture
//
//  Created by liuyunxuan on 15/2/3.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MPItemToolDelegate <NSObject>
@optional
-(void)firstIntoAppWithItems:(NSArray *)dicArray;
-(void)loadMoreWithItems:(NSArray *)dictArray;
@end
