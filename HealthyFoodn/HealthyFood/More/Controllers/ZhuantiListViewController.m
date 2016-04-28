//
//  ZhuantiListViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZhuantiListViewController.h"
#import "InterFace.h"
#import "MyTabbar.h"
#import "DownLoadManager.h"
#import "ZhuantiListItem.h"
#import "MyNavigationItem.h"
@interface ZhuantiListViewController ()

{
    UIWebView *_webView;
    NSMutableArray *_dataSource;
}
@end

@implementation ZhuantiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    [self loadMyNavigationBar];
    
    [self loadDataSource];
    
    
    [self loadMyWebView];

}

-(void)loadMyNavigationBar
{
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";
    
    [self createMyNavigationBarTitle:_name andTitleView:nil andLeftItems:@[leftItem] andRightItems:nil andSEL:@selector(btnClick:) andClass:self];
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

-(void)loadDataSource
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:ZHUANTI_DETAIL_URL,_dishesID] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:ZHUANTI_DETAIL_URL,_dishesID] andDownLoadType:6];
}
-(void)downLoadDataFinish
{
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:ZHUANTI_DETAIL_URL,_dishesID]];
    
    
    [self webViewLoadData];
}

-(void)loadMyWebView
{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    [self.view addSubview:_webView];
    
    
    
    
}
-(void)webViewLoadData
{
    NSURL *url=[NSURL URLWithString:((ZhuantiListItem *)_dataSource.lastObject).content_url];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    
    [_webView loadRequest:request];

  
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
