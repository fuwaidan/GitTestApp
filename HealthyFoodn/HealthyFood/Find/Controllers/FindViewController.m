//
//  FindViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "FindViewController.h"
#import "InterFace.h"
#import "DownLoadManager.h"
#import "RecipeItem.h"
#import "ResultItem.h"
#import "UIImageView+WebCache.h"

#import "UIImage+MultiFormat.h"
#import "ZaoCanItem.h"
#import "ZaoCanViewController.h"
@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UIScrollView *_scrollView;
    
    UIPageControl *_pageControl;
    
    NSMutableArray *_headerArray;//头视图数据
    
    UIView *_headTableView;//头视图
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataSource;
    
    NSMutableArray *_zaoCanArray;//早餐数据
    
    
    int _index;
    
    
    
    
}
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    [self loadDataSource];
    
   // [self loadHeadView];
    
    [self loadMyTableView];
}



#pragma mark - TableView
-(void)loadMyTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, ScreenBounds.size.width, ScreenBounds.size.height-49)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=100;
    [self.view addSubview:_tableView];
//    [self loadHeadView];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _dataSource.count;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",_zaoCanArray.count);
    return _zaoCanArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName] ;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //单元格右侧小箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
   // cell.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    ZaoCanItem *item=[_zaoCanArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=item.text;
    cell.imageView.image=[UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cookbook-cn.appcookies.com%@",item.thumb]]]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZaoCanViewController *zc=[[ZaoCanViewController alloc]init];
    
  
    zc.tit=((ZaoCanItem *)[_zaoCanArray objectAtIndex:indexPath.row]).text;
    
    [self.navigationController pushViewController:zc animated:YES];
}



#pragma mark - 头视图
-(void)loadHeadView
{
    
    
    _headTableView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 200)];
    _headTableView.backgroundColor=[UIColor whiteColor];
    
   
    [self.view addSubview:_headTableView];
    
    //滚动视图
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 200)];
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [_headTableView addSubview:_scrollView];
    
    //设置PageControl
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(ScreenBounds.size.width/2-50, _scrollView.frame.size.height-20, 100,20)];
    _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [_headTableView addSubview:_pageControl];
    
    [self loadHeadViewDataSource];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pageTurn) userInfo:nil repeats:YES];
    
}

      //  [hootButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hootItem.Cover]]] forState:UIControlStateNormal];
//    UIImage *image=[UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hootItem.Cover]]];
//



-(void)pageTurn
{
    _index++;
    if (_index>_headerArray.count-1) {
        _index=0;
    }
    [UIView animateWithDuration:0.7 animations:^{
        _scrollView.contentOffset=CGPointMake((_index)/2*ScreenBounds.size.width, 0);
    }];
    _pageControl.currentPage=_index/2;
    
}
#pragma mark - 下载数据
-(void)loadDataSource
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:FENLEI_LIST_URL object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:FENLEI_LIST_URL andDownLoadType:7];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:ZAOCAN_URL object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:ZAOCAN_URL andDownLoadType:8];
    
}

-(void)downLoadDataFinish
{
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:FENLEI_LIST_URL];
    
    _zaoCanArray=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:ZAOCAN_URL];

    
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:YES];
    
}

-(void)loadHeadViewDataSource
{
    
    //前面放最后一张图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(-ScreenBounds.size.width , 0, ScreenBounds.size.width, 200)];
    RecipeItem *recipeItem=[_headerArray objectAtIndex:_headerArray.count-1];
    [imageView sd_setImageWithURL:[NSURL URLWithString:recipeItem.img]];
    [_scrollView addSubview:imageView];
    
    
    _headerArray=((ResultItem *)_dataSource.lastObject).recipeArray;
    for (int i=0;i<[_headerArray count];i++ ) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenBounds.size.width, 0, ScreenBounds.size.width, 200)];
        imageView.userInteractionEnabled=YES;
        imageView.tag=2000+i;
        RecipeItem *recipeItem=[_headerArray objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:recipeItem.img]];
        [_scrollView addSubview:imageView];
        
    }
    
    //最后面放前面一张
    UIImageView *lastView=[[UIImageView alloc]initWithFrame:CGRectMake((_headerArray.count)*ScreenBounds.size.width , 0, ScreenBounds.size.width, 200)];
    RecipeItem *lastImage=[_headerArray objectAtIndex:0];
    [lastView sd_setImageWithURL:[NSURL URLWithString:lastImage.img]];
    [_scrollView addSubview:lastView];
    
    
    _scrollView.contentSize=CGSizeMake((_headerArray.count+2)*ScreenBounds.size.width, 200);
    _pageControl.numberOfPages=[_headerArray count];
    
    

}

-(void)shuaxin
{
    [_tableView reloadData];
    [self loadHeadView];
    
    //准备头视图数据
   // [self loadHeadViewDataSource];
   
    
}
#pragma mark - UIScrollerViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView==_scrollView) {
//        _pageControl.currentPage=scrollView.contentOffset.x/ScreenBounds.size.width;
//        if (scrollView.contentOffset.x >(_headerArray.count-1)*ScreenBounds.size.width)
//        {
//            scrollView.contentOffset=CGPointMake(0, 0);
//            _pageControl.currentPage=0;
//            
//        }
//        else if (scrollView.contentOffset.x<0)
//        {
//            scrollView.contentOffset=CGPointMake((_headerArray.count-1)*ScreenBounds.size.width, 0);
//            _pageControl.currentPage=_headerArray.count-1;
//        }
//    }
//}

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
