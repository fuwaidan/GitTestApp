//
//  ZhuanTiViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZhuanTiViewController.h"
#import "MyNavigationItem.h"
#import "MyTabbar.h"
#import "InterFace.h"
#import "ZhuantiTableViewCell.h"
#import "ZhuantiListViewController.h"
#import "DownLoadManager.h"
#import "DiTuViewController.h"
#import "MJRefresh.h"

@interface ZhuanTiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_ztTableView;//专题
    NSMutableArray *_ztMutableArray;
    
    NSInteger page;
}
@end

@implementation ZhuanTiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    page=1;
    [self loadMyNavigationBar];
    [self loadTableView];
    
    [self loadDataSource];
    [self refreshView];
    
    
}
-(void)loadMyNavigationBar
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"做出特色来！";
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"register_lbs@2x.png";
    MyNavigationItem *rightItem=[[MyNavigationItem alloc]init];
    rightItem.itemImageName=@"item-more@2x.png";
    
    [self createMyNavigationBarTitle:nil andTitleView:titleLabel andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(btnClick:) andClass:self];
}
//定位按钮
-(void)btnClick:(UIButton *)btn
{
    NSLog(@"%@",btn);
    
    if (btn.tag==1000)
    {
        
        DiTuViewController *ditu=[[DiTuViewController alloc]init];
        
        [self.navigationController pushViewController:ditu animated:YES];
    }
}


-(void)refreshView
{
     __weak __typeof(self) weakSelf=self;
    _ztTableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
       // page++;
        [weakSelf loadDataSource];
    }];
    [_ztTableView.header beginRefreshing];
    
    _ztTableView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf loadDataSource];
    }];
    [_ztTableView.footer beginRefreshing];

}

#pragma mark - TableView
-(void)loadTableView
{
    _ztTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    _ztTableView.delegate=self;
    _ztTableView.dataSource=self;
    _ztTableView.rowHeight=170;
    _ztTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_ztTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ztMutableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellName=@"cell";
    ZhuantiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZhuantiTableViewCell" owner:self options:nil]lastObject];
    }

    //[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
//    [UIImage imageWithData:da]
    
    cell.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setDataWithZhuantiItem:[_ztMutableArray objectAtIndex:indexPath.row]];
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        ZhuantiListViewController *zvc=[[ZhuantiListViewController alloc]init];
        
        zvc.dishesID=((ZhuantiItem *)[_ztMutableArray objectAtIndex:indexPath.row]).ID;
        
        zvc.name=((ZhuantiItem *)[_ztMutableArray objectAtIndex:indexPath.row]).title;
        [self.navigationController pushViewController:zvc animated:YES];
   

}



#pragma mark - 下载数据
-(void)loadDataSource
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:ZHUANTI_LIST_URL,page] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:ZHUANTI_LIST_URL,page] andDownLoadType:4];
    
}


-(void)downLoadDataFinish
{
    
    
    _ztMutableArray=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:ZHUANTI_LIST_URL,page]];
    
    [_ztTableView.header endRefreshing];
    [_ztTableView.footer endRefreshing];
    
    //主线程刷新
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:YES];
   
}
-(void)shuaxin
{
   [_ztTableView reloadData];  
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
