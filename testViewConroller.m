//
//  testViewConroller.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/23.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "testViewConroller.h"
#import "NetWorkDAO.h"
#import "KeychainItemWrapper.h"
#import "MPCacheTool.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "MPItemTool.h"

@interface testViewConroller()<NetWorkDAODelegate,MPItemToolDelegate>
@property (weak, nonatomic) IBOutlet UITextField *test_field;
@property (strong,nonatomic) NetWorkDAO *DAO;
@property (strong,nonatomic) MPItemTool *tool;
@end
@implementation testViewConroller
-(void)viewDidLoad
{

    //NSLog(@"%d",mpcacheABC);
    _DAO = [[NetWorkDAO alloc]init];
    _DAO.delegate = self;
    
    _tool = [[MPItemTool alloc]init];
    _tool.delegate = self;

}
- (IBAction)testAction:(id)sender {
    [_DAO getDetail:_test_field.text];
}
-(void)getDetailSuccessWithArray:(NSArray *)detailArray
{
    NSLog(@"detailArray = %@",detailArray);
}
- (IBAction)write:(id)sender {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"mapPicture" accessGroup:@"hook up"];
    [wrapper setObject:_test_field.text forKey:(__bridge id)(kSecAttrAccount)];

}

- (IBAction)delete:(id)sender {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"mapPicture" accessGroup:@"hook up"];
    [wrapper resetKeychainItem];
    
}
- (IBAction)show:(id)sender {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"mapPicture" accessGroup:@"hook up"];
    NSString *str =[wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    NSLog(@"keychai=%@",str);
}
- (IBAction)removeImageCache:(id)sender {
    SDImageCache *cacheManager = [SDImageCache sharedImageCache];
    [cacheManager clearMemory];
    [cacheManager clearDisk];
}
- (IBAction)createTable:(id)sender {
    [MPCacheTool initialize];
}
- (IBAction)testBlock:(id)sender {
    [_tool loadMoreWithCoordinate:@"testViewController input coordinate for testBlock"];
    
}
-(void)loadMoreWithItems:(NSArray *)items
{
    NSLog(@"testViewController loadMoreWithItems.count%d",items.count);
}
- (IBAction)firstOpenApp:(id)sender {

    [_tool itemsBeginWithParam:@"firstOpenApp"];
}
-(void)firstIntoAppWithItems:(NSArray *)items
{
    NSLog(@"testViewController items:%@",items);
}
- (IBAction)removeCache:(id)sender {
    [MPCacheTool deleteItems];
}

//-(NSString *)getmyUIUD
//{
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"protectEyer" accessGroup:@"com.tnvovationstations.protectEyer"];
//    NSString *userid=[wrapper objectForKey:(__bridge id)kSecAttrAccount];
//    return userid;
//}
//
//-(void)writemyUIUD:(NSString *)userid
//{
//    
//    if ([self isNeedToRegister]) {
//        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"protectEyer" accessGroup:@"com.tnvovationstations.protectEyer"];
//        [wrapper setObject:userid forKey:(__bridge id)kSecAttrAccount];
//    }
//    
//}


@end
