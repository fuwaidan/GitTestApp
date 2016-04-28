//
//  ZaoCanListViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZaoCanListViewController.h"
#import "InterFace.h"
#import "MyTabbar.h"
@interface ZaoCanListViewController ()
{
    UIWebView *_webView;
    
}
@end

@implementation ZaoCanListViewController


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
    
    
    [self loadWebView];
    
    
    //返回按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40 , 40);
    [button setBackgroundImage:[UIImage imageNamed:@"详情返回@2x.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(fanHuiClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

-(void)fanHuiClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)loadWebView
{
    _webView=[[UIWebView alloc]initWithFrame:ScreenBounds];
    [self.view addSubview:_webView];
    
    [self webViewLoadData];
    
    
}

-(void)webViewLoadData
{
    
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:ZAOCAN_DETAIL_URL,_ID]];
    
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
