//
//  HomeTableViewController.m
//  mapPicture
//
//  Created by liuyunxuan on 15/1/28.
//  Copyright (c) 2015年 liuyunxuan. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HomeMapViewController.h"
#import "MPItem.h"
#import "MPItemFrame.h"
#import "MPItemCell.h"
#import "MPItemTool.h"
#import "NetWorkDAO.h"
#import "MJRefresh.h"
#import "DetailViewController.h"

@interface HomeTableViewController ()<UITableViewDataSource,UITableViewDelegate,NetWorkDAODelegate,MJRefreshBaseViewDelegate,MPItemToolDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *itemFrames;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic,strong)NetWorkDAO *DAO;
@property (nonatomic,strong)MPItemTool *tool;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshView];
    [self setData];
    [self linkToMap];
}
#pragma 初始化
-(void)setData{
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tool=[[MPItemTool alloc]init];
    _tool.delegate = self;
    [_tool itemsBeginWithParam:@"HomeTableController setData"];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    
}
-(void)setupRefreshView
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}
-(void)linkToMap
{
    UIBarButtonItem *RightItem = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStylePlain
                                                                target:self action:@selector(jumpIntoMap)];
    self.navigationItem.rightBarButtonItem = RightItem;
}
-(void)jumpIntoMap
{
    HomeMapViewController *mapVC = [[HomeMapViewController alloc]init];
    [self presentViewController:mapVC animated:YES completion:nil];
}
#pragma itemsToolDelegate
-(void)loadMoreWithItems:(NSArray *)items
{
    NSMutableArray *itemFrames = [NSMutableArray array];
    for (MPItem *item in items) {
        MPItemFrame *itemFrame = [[MPItemFrame alloc]init];
        itemFrame.item = item;
        [itemFrames addObject:itemFrame];
    }
    _itemFrames = itemFrames;
    [self.tableView reloadData];

}
-(void)firstIntoAppWithItems:(NSArray *)items
{
    NSMutableArray *itemFrames = [NSMutableArray array];
    for (MPItem *item in items) {
        MPItemFrame *itemFrame = [[MPItemFrame alloc]init];
        itemFrame.item = item;
        [itemFrames addObject:itemFrame];
    }
    _itemFrames = itemFrames;
    [self.tableView reloadData];

}
#pragma refresh Delegate and Action
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)); // 1
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // 2
        [refreshView endRefreshing];
    });

}

-(void)loadMoreData
{
    NSLog(@"loadMoreData");
    [_tool loadMoreWithCoordinate:@"tableviewcoller loadMoreData"];
}
-(void)loadNewData
{
    NSLog(@"loadNewData");
    [_tool loadMoreWithCoordinate:@"tableviewcontroller loadNewData"];
}
-(void)dealloc
{
    [self.header free];
    [self.footer free];

}

#pragma tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPItemCell *cell = [MPItemCell cellWithTableView:tableView];
    cell.itemFrame = self.itemFrames[indexPath.row];
 
    [self MonitorForCell:cell rowAtIndexPath:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPItemFrame *itemFrame = [_itemFrames objectAtIndex:indexPath.row];
    return itemFrame.cellHeigt;
}


#pragma mark - NetWork Delegate
-(void)getDetailSuccessWithArray:(NSArray *)detailArray
{
    NSMutableArray *itemFrames = [NSMutableArray array];
    for (NSDictionary *dic in detailArray) {
        MPItem *item = [MPItem itemWithDict:dic];
        MPItemFrame *itemFrame = [[MPItemFrame alloc]init];
        itemFrame.item = item;
        [itemFrames addObject:itemFrame];
    }
    _itemFrames = itemFrames;
    [self.tableView reloadData];
}
#pragma the action for cell
-(void)MonitorForCell:(MPItemCell *)cell rowAtIndexPath:(int)row
{
    cell.share_Button.tag = row;
    [cell.share_Button addTarget:self action:@selector(toShare:) forControlEvents:UIControlEventTouchDown];
    
    cell.reply_Button.tag = row;
    [cell.reply_Button addTarget:self action:@selector(toReply:) forControlEvents:UIControlEventTouchDown];
    
    cell.praise_Button.tag = row;
    [cell.praise_Button addTarget:self action:@selector(toPraise:) forControlEvents:UIControlEventTouchDown];
}
-(void)toShare:(UIButton *)button
{
    NSLog(@"%d",button.tag);
}
-(void)toReply:(UIButton *)button
{
    NSNumber *number = [NSNumber numberWithInt:button.tag];
    [self performSegueWithIdentifier:@"toDetail" sender:number];
    NSLog(@"button.tag=%d",button.tag);
}
-(void)toPraise:(UIButton *)button
{
    NSLog(@"%d",button.tag);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVc = segue.destinationViewController;
    NSIndexPath *index = [NSIndexPath indexPathForRow:[sender intValue] inSection:0];
    MPItemCell *cell =(MPItemCell *)[_tableView cellForRowAtIndexPath:index];
    detailVc.item = cell.itemFrame.item;
}
@end
