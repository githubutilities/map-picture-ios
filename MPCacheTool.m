//
//  MPCacheTool.m
//  mapPicture
//
//  Created by liuyunxuan on 15/2/1.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "MPCacheTool.h"
#import "MPItem.h"
#import <FMDB.h>

@implementation MPCacheTool
static FMDatabaseQueue *_queue;
+(void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathExtension:@"items.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_item(id integer primary key autoincrement,item blob);"];
    }];
}
+(void)addDic:(NSDictionary *)dic
{
    MPItem *item = [[MPItem alloc]init];
    item = [MPItem itemWithDict:dic];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];

    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_item (item) values(?);",data];
    }];
}
+(void)addDics:(NSArray *)dicArray
{
    for (NSDictionary *dic in dicArray) {
        [self addDic:dic];
    }
}
+(NSArray *)shareItems
{
    __block NSMutableArray *itemArray= nil;
    [_queue inDatabase:^(FMDatabase *db) {
        itemArray = [NSMutableArray array];
        FMResultSet *result = nil;
        result = [db executeQuery:@"select * from t_item;"];
        while (result.next) {
            NSData *data = [result dataForColumn:@"item"];
            MPItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [itemArray addObject:item];
        }
    }];
    
    return itemArray;
}
+(void)deleteItems
{
    NSLog(@"deleteItems");
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from t_item"];
    }];
}

@end
