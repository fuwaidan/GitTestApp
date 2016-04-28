//
//  ListViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ListViewController.h"
#import "MyNavigationItem.h"
#import "DownLoadManager.h"
#import "InterFace.h"
#import "RootItem.h"
#import "MyTabbar.h"
#import "TlistItem.h"
#import "ListItem.h"
#import "MenuItem.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "ListTableViewCell.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
@end

@implementation ListViewController



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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self loadMyNavigationBar];
    
    [self loadTableView];
    
    [self downLoadData];
    

}

#pragma mark - 导航条
-(void)loadMyNavigationBar
{
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"列表";
    
    [self createMyNavigationBarTitle:nil andTitleView:titleLabel andLeftItems:@[leftItem] andRightItems:nil andSEL:@selector(btnClick:)  andClass:self];
}
-(void)btnClick:(UIButton *)btn
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
#pragma mark - loadTableView
-(void)loadTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,ScreenBounds.size.width , ScreenBounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=70;
    
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ((MenuItem *)[_dataSource lastObject]).tlistArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MenuItem *item1 = [_dataSource lastObject];
    TlistItem *item2 = [item1.tlistArray objectAtIndex:section];
    
    return item2.listArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MenuItem *item1 = [_dataSource lastObject];
    TlistItem *item2 = [item1.tlistArray objectAtIndex:section];
    return [NSString stringWithFormat:@"%@",item2.title];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"cell";
    ListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ListTableViewCell" owner:self options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MenuItem *item1 = [_dataSource lastObject];
    TlistItem *item2 = [item1.tlistArray objectAtIndex:indexPath.section];
    
    ListItem *item=[item2.listArray objectAtIndex:indexPath.row];
    
    [cell setDataWithListItem:item];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *list=[[DetailViewController alloc]init];
    
    MenuItem *item1=[_dataSource lastObject];
    TlistItem *item2=[item1.tlistArray objectAtIndex:indexPath.section];
    
    list.dataArray=item2.listArray;
    
    list.currentID=(int)indexPath.row;
    
    
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 下载数据
-(void)downLoadData
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:SPECIAL_DETAIL_URL,_currentID] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:SPECIAL_DETAIL_URL,_currentID] andDownLoadType:2];
    
}
-(void)downLoadDataFinish
{
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:SPECIAL_DETAIL_URL,_currentID]];
    NSLog(@"7777777%@",_dataSource);
    //主线程刷新
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:NO];
    
}
-(void)shuaxin
{
    [_tableView reloadData];
    
    [self loadHeardView];
}

#pragma mark - loadHeardView
//准备头视图
-(void)loadHeardView
{
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 230)];
    _tableView.tableHeaderView=view;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 150)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:((MenuItem *)_dataSource.lastObject).thumb]];
    
    [view addSubview:imageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height-30, ScreenBounds.size.width, 30)];
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.backgroundColor=[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:0.70f];
    titleLabel.text=((MenuItem *)[_dataSource lastObject]).title;
    
    [imageView addSubview:titleLabel];
    
    UILabel *jianjieLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, ScreenBounds.size.width, view.frame.size.height-imageView.frame.size.height)];
    jianjieLabel.text=((MenuItem *)[_dataSource lastObject]).jianjie;
    jianjieLabel.font=[UIFont systemFontOfSize:12];
    jianjieLabel.numberOfLines = 0;
    [view addSubview:jianjieLabel];
    
    
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
