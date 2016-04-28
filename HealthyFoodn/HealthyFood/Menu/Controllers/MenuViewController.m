//
//  MenuViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "MenuViewController.h"
#import "MyNavigationItem.h"
#import "DownLoadManager.h"
#import "InterFace.h"
#import "RootItem.h"
#import "MenuTableViewCell.h"
#import "ListViewController.h"
#import "MJRefresh.h"

#import "RefreshHeader.h"
#import "DiTuViewController.h"
@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    
    NSInteger page;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    //导航条
    [self loadMyNavigationBar];
    //page=1;
    
    //下载数据
    [self downLoadData];
    
    //tableView
    [self loadMyTableView];
    //下拉刷新
    [self loadYiresh];
    //上拉加载
    [self loadMore];
    
}
//下拉刷新
-(void)loadYiresh
{
    __weak __typeof(self) weakSelf=self;
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //page++;
        [weakSelf downLoadData];
    }];
    [_tableView.header beginRefreshing];
}
//上拉加载
-(void)loadMore
{
    __weak __typeof(self) weakSelf=self;
    _tableView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf downLoadData];
    }];
    [_tableView.footer beginRefreshing];
}

#pragma mark - 导航条
-(void)loadMyNavigationBar
{
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"register_lbs@2x.png";
    
    MyNavigationItem *rightItem=[[MyNavigationItem alloc]init];
    rightItem.itemImageName=@"item-more@2x.png";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"花式菜系大全";
    
    [self createMyNavigationBarTitle:nil andTitleView:titleLabel andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(btnClick:) andClass:self];
    
}
//定位按钮
-(void)btnClick:(UIButton *)btn
{
    NSLog(@"%@",btn);
    
    if (btn.tag == 1000)
    {
      
        DiTuViewController *ditu=[[DiTuViewController alloc]init];
        
        [self.navigationController pushViewController:ditu animated:YES];
    }else if (btn.tag == 2000) {
        NSLog(@"lalalaaa啊啊啊");
        
        
    }
    
}

#pragma mark - TableView

-(void)loadMyTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=180;
    //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"cell";
    MenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MenuTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RootItem *item=[_dataSource objectAtIndex:indexPath.row];
    [cell setDataWithMenuItem:item];
    cell.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewController *lvc=[[ListViewController alloc]init];
    
    lvc.currentID=((RootItem *)[_dataSource objectAtIndex:indexPath.row]).resultsID;
    
    [self.navigationController pushViewController:lvc animated:YES];
    
}
#pragma mark - 数据下载

-(void)downLoadData
{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:SPECIAL_LIST_URL,page] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:SPECIAL_LIST_URL,page] andDownLoadType:1];
    
}

-(void)downLoadDataFinish
{
    
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:SPECIAL_LIST_URL,page]];
    
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:NO];
    
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
}
-(void)shuaxin
{
    [_tableView reloadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
