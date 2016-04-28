//
//  TopViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "TopViewController.h"
#import "MyNavigationItem.h"
#import "InterFace.h"
#import "DownLoadManager.h"
#import "RemenTableViewCell.h"
#import "XinpinCollectionViewCell.h"


#import "TopListViewController.h"

#import "DiTuViewController.h"
#import "MJRefresh.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TopViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIView *_view;
    
    UITableView *_rmTableView;//热门
    UICollectionView *_xpCollectionView;//新品
    
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_rmMutableArray;
    
    NSMutableArray *_xpMutableArray;
    
    
    
    NSInteger page;
   
}
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    page=1;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self loadMyNavigationBar];
    [self createScrollView];
    [self loadDataSource];
    [self refreshView];
    
}

#pragma mark - 导航条

-(void)loadMyNavigationBar
{
    NSArray *arr=@[@"热门",@"新品"];
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenBounds.size.width, 40)];
    for (int i=0; i<[arr count]; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
       // button.frame=CGRectMake(_view.center.x-i*60, 0, 50, 30);
        button.frame=CGRectMake((ScreenBounds.size.width-(arr.count*50+10))/2+i*60, 0, 50, 30);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag=1000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:button];
    }
    [self titleView];
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"register_lbs@2x.png";
    
    MyNavigationItem *rightItem=[[MyNavigationItem alloc]init];
    rightItem.itemImageName=@"item-more@2x.png";
    
    [self createMyNavigationBarTitle:nil andTitleView:_view andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(btnClick:) andClass:self];
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

//下面小的条形图
-(void)titleView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(_view.center.x-40, 34, 30, 4)];
    view.backgroundColor= [UIColor whiteColor];
    view.tag=2001;
    [_view addSubview:view];
    
}

//热门新品按钮点击事件
-(void)buttonClick:(UIButton *)button
{
    
    for (UIView *view in _view.subviews) {
        if (view.tag!=2001) {
           // NSLog(@"%@",_view.subviews);
            ((UIButton *)view).selected=NO;
        }
    }
    button.selected=YES;
    UIView *view=[_view viewWithTag:2001];
    CGPoint center=view.center;
    center.x=button.center.x;
    [UIView animateWithDuration:0.3 animations:^{
        view.center=center;
    }];
    
    //改变scrollView的偏移量
    _scrollView.contentOffset=CGPointMake((button.tag-1000)*ScreenBounds.size.width, 0);
}

//刷新
-(void)refreshView
{
   
    __weak __typeof(self) weakSelf=self;
    
    _rmTableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //page++;
            [weakSelf loadDataSource];
        }];
        [_rmTableView.header beginRefreshing];
    
    _xpCollectionView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
       // page++;
        [weakSelf loadDataSource];
        
    } ];
    
    [_xpCollectionView.header beginRefreshing];
    
    
    
    _rmTableView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf loadDataSource];
    }];
    [_rmTableView.footer beginRefreshing];
    
    _xpCollectionView.footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf loadDataSource];
    }];
    [_xpCollectionView.footer beginRefreshing];
    
}

#pragma mark - 创建滚动视图
-(void)createScrollView
{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 , ScreenBounds.size.width, ScreenBounds.size.height-64-49)];
    _scrollView.contentSize=CGSizeMake(ScreenBounds.size.width*2, 0);
    _scrollView.pagingEnabled=YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate=self;
    
    _rmTableView=[self createTableViewAtIndex:0];
    
    _xpCollectionView=[self createCollectionViewAtIndex:1];
  
    
    [_scrollView addSubview:_rmTableView];
    [_scrollView addSubview:_xpCollectionView];
    
    
    [self.view addSubview:_scrollView];
    

    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    for (UIButton *button in _view.subviews)
    {
        if (button.tag-1000==_scrollView.contentOffset.x/ScreenBounds.size.width)
        {
            [self buttonClick:button];
        }
    }
    
}

//创建 热门tableView
-(UITableView *)createTableViewAtIndex:(NSInteger)index
{
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(index*ScreenBounds.size.width, 0, ScreenBounds.size.width, ScreenBounds.size.height-49) style:UITableViewStylePlain];

    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=170;
    
    return tableView;
    
}
//创建  新品collectionView

-(UICollectionView *)createCollectionViewAtIndex:(NSInteger)index
{
    //布局文件
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置每个方块的大小
    layout.itemSize=CGSizeMake((ScreenBounds.size.width-30)/2, 140);
    //设置滚动的方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //layout.minimumInteritemSpacing=10;
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    //实例化控件对象
    _xpCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(index*ScreenBounds.size.width, 0, ScreenBounds.size.width, ScreenBounds.size.height-49) collectionViewLayout:layout];
    
    _xpCollectionView.delegate=self;
    _xpCollectionView.dataSource=self;
    _xpCollectionView.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    [_xpCollectionView registerNib:[UINib nibWithNibName:@"XinpinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    return _xpCollectionView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_rmTableView) {
        return _rmMutableArray.count;
        
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    
    if (tableView==_rmTableView)
    {
        RemenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"RemenTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Remenitem *item = [_rmMutableArray objectAtIndex:indexPath.row];
        
        [cell setDataWithRemen:item];
        
        cell.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
        //视频播放

        cell.playMovie = ^{
            MPMoviePlayerViewController *movie=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:item.video]];
            [self presentMoviePlayerViewControllerAnimated:movie];
        };

        
        return cell;
    }
       return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_rmTableView)
    {
        TopListViewController *topList=[[TopListViewController alloc]init];
        topList.dishesID=((Remenitem *)[_rmMutableArray objectAtIndex:indexPath.row]).ID;
        
         [self.navigationController pushViewController:topList animated:YES];
    }
    
}


#pragma  mark - 新品
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_xpCollectionView) {
        return _xpMutableArray.count;
        
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XinpinCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Remenitem *item=[_xpMutableArray objectAtIndex:indexPath.row];
    
    [cell setDataWithRemen:item];
    
    cell.playMovie=^{
        MPMoviePlayerViewController *movie=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:item.video]];
        [self presentMoviePlayerViewControllerAnimated:movie];
        
    };
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopListViewController *topList=[[TopListViewController alloc]init];
    topList.dishesID=((Remenitem *)[_xpMutableArray objectAtIndex:indexPath.row]).ID;
    
    [self.navigationController pushViewController:topList animated:YES];
    
    
}

#pragma mark - 下载数据
-(void)loadDataSource
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:HOOT_LIST_URL,page] object:nil];
    
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:HOOT_LIST_URL,page] andDownLoadType:3];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:XINPIN_LIST_URL,page] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:XINPIN_LIST_URL,page] andDownLoadType:3];
    
    
}
-(void)downLoadDataFinish
{
    _rmMutableArray=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:HOOT_LIST_URL,page]];
    
    
    _xpMutableArray=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:XINPIN_LIST_URL,page]];
   
       //主线程刷新
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:NO];
    
}

-(void)shuaxin
{
    [_rmTableView reloadData];
    [_xpCollectionView reloadData];
    [_rmTableView.header endRefreshing];
    [_xpCollectionView.header endRefreshing];
    
    [_rmTableView.footer endRefreshing];
    [_xpCollectionView.footer endRefreshing];
    

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
