//
//  InstagramItem.h
//  iOS8SelfSizingCells
//
//  Created by dw_iOS on 14-10-22.
//  Copyright (c) 2014年 广州华多网络科技有限公司 多玩事业部 iOS软件工程师 曾宪华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramItem : NSObject

@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, strong) UIImage *photo;

+ (NSArray *)newDataSource;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
