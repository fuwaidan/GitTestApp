//
//  SaveViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "SaveViewController.h"
#import "InterFace.h"
#import "Database.h"
#import "SaveTableViewCell.h"
#import "SaveItem.h"
#import "UIImageView+WebCache.h"

#import <MediaPlayer/MediaPlayer.h>
#import "MJRefresh.h"
#import "MyNavigationItem.h"
@interface SaveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    [self loadMyNavigationBar];
    
    [self loadTableView];
    [self loadDataSource];
    [self loadRefresh];
    
    
}
-(void)loadMyNavigationBar
{
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";
    [self createMyNavigationBarTitle:@"我的收藏" andTitleView:nil andLeftItems:@[leftItem] andRightItems:nil andSEL:@selector(btnClick:) andClass:self];
}

-(void)btnClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadDataSource
{
    _dataSource=[[Database sharedDatabase]selectAllRmListItem];
    
    [_tableView reloadData];
    [_tableView.header endRefreshing];
    
}

-(void)loadTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=150;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
     SaveTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SaveTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SaveItem *item=[_dataSource objectAtIndex:indexPath.row];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:item.image]];
    cell.title.text=item.dashes_name;
    
//    cell.playMovie=^{
//        
//        MPMoviePlayerViewController *movie=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:item.material_video]];
//        [self presentMoviePlayerViewControllerAnimated:movie];
//    };
    
    return cell;
    
}

//下拉刷新
-(void)loadRefresh
{
    __weak __typeof(self) weakSelf=self;
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadDataSource];
    }];
    [_tableView.header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
}


@end
