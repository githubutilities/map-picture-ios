//
//  DetailViewController.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/30.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailItemFrame.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) DetailItemFrame *mainItemFrame;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    NSLog(@"%@",_cell);
   
}

#pragma tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailItemCell *cell = [DetailItemCell cellWithTableView:tableView];
        DetailItemFrame *itemFrame = [[DetailItemFrame alloc]init];
        itemFrame.item = _item;
        cell.itemFrame = itemFrame;
        _mainItemFrame = cell.itemFrame;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _mainItemFrame.cellHeigt;
}
-(void)dealloc
{
    NSLog(@"detail dismiss");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
