//
//  ZaoCanViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZaoCanViewController.h"
#import "MyTabbar.h"
#import "MyNavigationItem.h"
#import "InterFace.h"
#import "ZaoCanTableViewCell.h"
#import "ZaoCanListItem.h"
#import "DownLoadManager.h"
#import "ZaoCanListViewController.h"

@interface ZaoCanViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation ZaoCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    [self loadMyNavigationBar];
    
    [self loadTableView];
    
    [self loadDataSource];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *array = self.tabBarController.view.subviews;
    NSLog(@"%@",array);
    for (id obj in array) {
        if ([obj isKindOfClass:[UITabBar class]]) {
            ((UITabBar *)obj).hidden = YES;
        }
        else if ( [obj isKindOfClass:[MyTabbar class]]) {
            ((MyTabbar *)obj).hidden = YES;
        }
    }
    
}

#pragma mark - 导航条
-(void)loadMyNavigationBar
{
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";

    [self createMyNavigationBarTitle:_tit andTitleView:nil andLeftItems:@[leftItem] andRightItems:nil andSEL:@selector(backClick:) andClass:self];
    
}
-(void)backClick:(UIButton *)btn
{
    
    for (id obj in [self.tabBarController.view subviews])
    {
        if ([obj isKindOfClass:[MyTabbar class]])
        {
            ((MyTabbar *)obj).hidden=NO;
            
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)loadTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=90;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *cellName=@"cell";
    ZaoCanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ZaoCanTableViewCell" owner:self options:nil].lastObject;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    ZaoCanListItem *item=[_dataSource objectAtIndex:indexPath.row];
    
    
    [cell setDataWithZaoCanItem:item];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZaoCanListViewController *list=[[ZaoCanListViewController alloc]init];
    
    list.ID=((ZaoCanListItem *)[_dataSource objectAtIndex:indexPath.row]).ID;
    
    [self.navigationController pushViewController:list animated:YES];
}


-(void)loadDataSource
{

    NSString *str=[_tit stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadDataFinish) name:[NSString stringWithFormat:ZAOCAN_LIST_URL,str ] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:ZAOCAN_LIST_URL,str] andDownLoadType:9];
    
}
-(void)downloadDataFinish
{
     NSString *str=[_tit stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:ZAOCAN_LIST_URL,str]];
    
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:NO];
    
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
