//
//  NetWorkDAO.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/23.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "NetWorkDAO.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import <UIKit/UIKit.h>
#import <MKNetworkOperation.h>
#import <MKNetworkEngine.h>


#define HOST_PATH @""
#define HOST_NAME @"contaccyclone.sinaapp.com/"

#define coordinateKey @"coordinate"
#define jsonFormatKey @"jsonFormat"
#define resultCodeKey @"resultCode"
#define resultDetailArrayKey @"resultArray"

@implementation NetWorkDAO

-(void)getDetail:(NSString *)coordinate
{
    NSLog(@"输入的coordinate%@",coordinate);
    NSString *path = [@"index.php" URLEncodedString];
    NSMutableDictionary *coordinateDict = [[NSMutableDictionary alloc]init];
    [coordinateDict setValue:coordinate forKey:coordinateKey];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:coordinateDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
    [param setValue:jsonString forKey:jsonFormatKey];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:HOST_NAME];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *responseData = [completedOperation responseData];
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"responseDict =%@" , responseArray);
//        NSNumber *resultCodeNumber = [responseDict objectForKey:resultCodeKey];
//        NSArray *detailArray = [responseDict objectForKey:resultDetailArrayKey];
//        if ([resultCodeNumber integerValue]> 0) {
//            if ([self.delegate respondsToSelector:@selector(getDetailSuccessWithArray:)]) {
//                [self.delegate getDetailSuccessWithArray:detailArray];
//            }
//        }else{
//            NSLog(@"错误信息");
//            
//        }
        if([self.delegate respondsToSelector:@selector(getDetailSuccessWithArray:)]){
            [self.delegate getDetailSuccessWithArray:responseArray];
        }

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"系统连接错误:%@",error);
    }];
    [engine enqueueOperation:op];
}
-(void)upLoadImage:(UIImage *)uploadImage uploadText:(NSString *)uploadText
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:uploadText forKey:@"detail"];
//    [dic setValue:coordinate forKey:coordinateKey];
//    [dic setValue:keyChain forKey:@"keychain"];
    [dic setValue:uploadImage forKey:@"image"];
}
+(void)postWithParams:(NSString *)coordinate success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSLog(@"输入的coordinate%@",coordinate);
    NSString *path = [@"index.php" URLEncodedString];
    NSMutableDictionary *coordinateDict = [[NSMutableDictionary alloc]init];
    [coordinateDict setValue:coordinate forKey:coordinateKey];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:coordinateDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
    [param setValue:jsonString forKey:jsonFormatKey];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:HOST_NAME];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *responseData = [completedOperation responseData];
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"responseDict =%@" , responseArray);
        //        NSNumber *resultCodeNumber = [responseDict objectForKey:resultCodeKey];
        //        NSArray *detailArray = [responseDict objectForKey:resultDetailArrayKey];
        //        if ([resultCodeNumber integerValue]> 0) {
        //            if ([self.delegate respondsToSelector:@selector(getDetailSuccessWithArray:)]) {
        //                [self.delegate getDetailSuccessWithArray:detailArray];
        //            }
        //        }else{
        //            NSLog(@"错误信息");
        //
        //        }
        if (success) {
            success(responseArray);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [engine enqueueOperation:op];
}


@end
