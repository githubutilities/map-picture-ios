//
//  UIImage+MP.h
//  mapPicture
//
//  Created by liuyunxuan on 15/1/24.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MP)
/**
 *  返回没有渲染的原始图片
 *
 *  @param name 文件名
 */
+ (UIImage *)originalImageWithName:(NSString *)name;

/**
 *  返回能够自由拉伸不变形的图片
 *
 *  @param name 文件名
 *
 *  @return 能够自由拉伸不变形的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *   返回能够自由拉伸不变形的图片
 *
 *  @param name      文件名
 *  @param leftScale 左边需要保护的比例（0~1）
 */
+ (UIImage *)resizedImage:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale;

@end
