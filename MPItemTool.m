//
//  MPItemTool.m
//  mapPicture
//
//  Created by liuyunxuan on 15/2/2.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPItemTool.h"
#import "AppDelegate.h"
#import "MPCacheTool.h"
#import "NetWorkDAO.h"
#import <MKNetworkOperation.h>
#import <MKNetworkEngine.h>
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#define HOST_NAME @"contaccyclone.sinaapp.com/"

#define coordinateKey @"coordinate"
#define jsonFormatKey @"jsonFormat"
#define resultCodeKey @"resultCode"
#define resultDetailArrayKey @"resultArray"


@interface MPItemTool()<NetWorkDAODelegate>

@end
static NetWorkDAO *_DAO;
@implementation MPItemTool
+(void)initialize
{
    _DAO = [[NetWorkDAO alloc]init];
}
-(void)loadMoreWithCoordinate:(NSString *)coordinate
{
    if (!APP_isLinked) {
        NSLog(@"之前未联网刷新 现在刷新");
        [NetWorkDAO postWithParams:@"params" success:^(NSArray *dicArray) {
            [MPCacheTool deleteItems];
            [MPCacheTool addDics:dicArray];
            if([self.delegate respondsToSelector:@selector(loadMoreWithItems:)]){
                [self.delegate loadMoreWithItems:[MPCacheTool shareItems]];
            }
            APP_isLinked= YES;
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else
    {
        NSLog(@"之前联网 现在刷新");
        [NetWorkDAO postWithParams:@"params" success:^(NSArray *responArray) {
            [MPCacheTool addDics:responArray];
            if([self.delegate respondsToSelector:@selector(loadMoreWithItems:)]){
                [self.delegate loadMoreWithItems:[MPCacheTool shareItems]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}


-(void)itemsBeginWithParam:(NSString *)coordinate
{
    NSArray * array = [MPCacheTool shareItems];
    if (array.count) {
        NSLog(@"刚进入程序刷新（本地有缓存");
        if ([self.delegate respondsToSelector:@selector(firstIntoAppWithItems:)]) {
            [self.delegate firstIntoAppWithItems:array];
        }
    }else{
        NSLog(@"刚进入程序刷新(本地没有缓存)%@",coordinate);
        [NetWorkDAO postWithParams:@"param" success:^(NSArray *dicArray) {
            
            [MPCacheTool addDics:dicArray];
            if([self.delegate respondsToSelector:@selector(firstIntoAppWithItems:)]){
                [self.delegate firstIntoAppWithItems:[MPCacheTool shareItems]];
            }
            APP_isLinked = YES;
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
//+(void)postWithString:(NSString *)string success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
//{
//    if (_delegate.isFirstOpen) {
//        NSLog(@"第一次进入程序然后刷新的结果");
//        [NetWorkDAO postWithParams:string success:^(NSArray *responArray) {
//            if (success) {
//                [MPCacheTool deleteItems];
//                [MPCacheTool addItems:responArray];
//                success([MPCacheTool shareItems]);
//            }
//        } failure:^(NSError *error) {
//            failure(error);
//        }];
//        _delegate.isFirstOpen = NO;
//    }else{
//        NSLog(@"非第一次进入程序刷新的结果");
//        [NetWorkDAO postWithParams:string success:^(NSArray *responArray) {
//            if (success) {
//                [MPCacheTool addItems:responArray];
//                success([MPCacheTool shareItems]);
//            }
//        } failure:^(NSError *error) {
//            failure(error);
//        }];
//
//    }
//
////    NSArray *array = [MPCacheTool shareItems];
////    //程序刚打开从手机缓存里面加载
////    if (_delegate.isFirstOpen) {
////        if (array.count) {//有缓存
////            if (success) {
////                success(array);
////            }
////        }else
////        {
////            //从网络上读取
////            [NetWorkDAO postWithParams:string success:^(NSArray *responArray) {
////                if (success) {
////                    [MPCacheTool addItems:responArray];
////                    success([MPCacheTool shareItems]);
////                }
////            } failure:^(NSError *error) {
////                failure(error);
////            }];
////        }
////    }else
////    {
////        //从网络上读取，然后加到数据库里面，然后再从数据库里面读取到success里面
////        [NetWorkDAO postWithParams:string success:^(NSArray *responArray) {
////            if (success) {
////                [MPCacheTool addItems:responArray];
////                success([MPCacheTool shareItems]);
////            }
////            
////        } failure:^(NSError *error) {
////            failure(error);
////        }];
////    }
//
//}
//-(void)loadMoreWithCoordinate:(NSString *)coordinate
//{
//    if (!APP_isLinked) {
//        NSLog(@"之前未联网刷新 现在刷新");
//        NSString *path = [@"index.php" URLEncodedString];
//        NSMutableDictionary *coordinateDict = [[NSMutableDictionary alloc]init];
//        [coordinateDict setValue:coordinate forKey:coordinateKey];
//        
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:coordinateDict options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//        NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
//        [param setValue:jsonString forKey:jsonFormatKey];
//        
//        MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:HOST_NAME];
//        MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
//        
//        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//            NSData *responseData = [completedOperation responseData];
//            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//            //NSLog(@"responseDict =%@" , responseArray);
//            //        NSNumber *resultCodeNumber = [responseDict objectForKey:resultCodeKey];
//            //        NSArray *detailArray = [responseDict objectForKey:resultDetailArrayKey];
//            //        if ([resultCodeNumber integerValue]> 0) {
//            //            if ([self.delegate respondsToSelector:@selector(getDetailSuccessWithArray:)]) {
//            //                [self.delegate getDetailSuccessWithArray:detailArray];
//            //            }
//            //        }else{
//            //            NSLog(@"错误信息");
//            //
//            //        }
//            [MPCacheTool addItems:responseArray];
//            if([self.delegate respondsToSelector:@selector(loadMoreWithItems:)]){
//                [self.delegate loadMoreWithItems:[MPCacheTool shareItems]];
//            }
//            
//        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//            NSLog(@"系统连接错误:%@",error);
//        }];
//        [engine enqueueOperation:op];
//        [MPCacheTool deleteItems];
//        APP_isLinked= YES;
//    }else
//    {
//        NSLog(@"之前联网 现在刷新");
//        NSString *path = [@"index.php" URLEncodedString];
//        NSMutableDictionary *coordinateDict = [[NSMutableDictionary alloc]init];
//        [coordinateDict setValue:coordinate forKey:coordinateKey];
//        
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:coordinateDict options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//        NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
//        [param setValue:jsonString forKey:jsonFormatKey];
//        
//        MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:HOST_NAME];
//        MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
//        
//        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//            NSData *responseData = [completedOperation responseData];
//            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//            //NSLog(@"responseDict =%@" , responseArray);
//            //        NSNumber *resultCodeNumber = [responseDict objectForKey:resultCodeKey];
//            //        NSArray *detailArray = [responseDict objectForKey:resultDetailArrayKey];
//            //        if ([resultCodeNumber integerValue]> 0) {
//            //            if ([self.delegate respondsToSelector:@selector(getDetailSuccessWithArray:)]) {
//            //                [self.delegate getDetailSuccessWithArray:detailArray];
//            //            }
//            //        }else{
//            //            NSLog(@"错误信息");
//            //
//            //        }
//            [MPCacheTool addItems:responseArray];
//            if([self.delegate respondsToSelector:@selector(loadMoreWithItems:)]){
//                [self.delegate loadMoreWithItems:[MPCacheTool shareItems]];
//            }
//            
//        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//            NSLog(@"系统连接错误:%@",error);
//        }];
//        [engine enqueueOperation:op];
//    }
//}

@end
