//
//  NSString+URLEncoding.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/23.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString *)URLEncodedString
{
    NSString *result=(NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("+$,#[] "), kCFStringEncodingUTF8));
    return result;
}

-(NSString *) URLDecodedString
{
    NSString *result=(NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}


@end
