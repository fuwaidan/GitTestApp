//
//  TopListViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "TopListViewController.h"
#import "DetailView.h"
#import "InterFace.h"
#import "DownLoadManager.h"
#import "MyTabbar.h"
#import "UIImageView+WebCache.h"
#import "RemenListItem.h"
#import "StepItem.h"
#import "StepTableViewCell.h"

#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"
#import "Database.h"
@interface TopListViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
   // UIActivityIndicatorView *_activityView;
    
}
@end

@implementation TopListViewController

// 隐藏tabbar
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
    
    if ([[Database sharedDatabase]selectDataWithRmListID:_dishesID])
    {
        
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadTableView];
    
    [self createDetailView];
    
    [self loadDataSource];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 20, 40, 40);
    [button setImage:[UIImage imageNamed:@"详情返回@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
//    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(ScreenBounds.size.width/2-10, ScreenBounds.size.height/2-10, 20, 20)];
//    //_activityView.hidesWhenStopped=YES;
//    _activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
//    [_activityView startAnimating];
//    
//    [self.view addSubview:_activityView];
    
    
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


//准备下面的  tabbar
-(void)createDetailView
{
    DetailView *dv=[[DetailView alloc]initWithFrame:CGRectMake(0, ScreenBounds.size.height, ScreenBounds.size.width, 49)];
    [dv createDetailViewWithClass:self andSEL:@selector(detailViewClick:)];
    [self.view addSubview:dv];
    [UIView animateWithDuration:0.2 animations:^{
        dv.frame=CGRectMake(0,ScreenBounds.size.height-49, ScreenBounds.size.width, 49);
    }completion:^(BOOL finished) {
        
    }];
}

// 下面按钮点击事件
-(void)detailViewClick:(UIButton *)btn
{
    if (btn.tag==0)
    {
        btn.selected=!btn.selected;
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"收藏_p@2x.png"] forState:UIControlStateNormal];
            
            [[Database sharedDatabase]insertDataWithRemenListItem:(RemenListItem *)_dataSource.lastObject];
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:@"确定收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction=[UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SDImageCache sharedImageCache]clearDisk];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
           
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"收藏@2x.png"] forState:UIControlStateNormal];
            
            [[Database sharedDatabase]deleteRmListItemWithID:((RemenListItem *)_dataSource.lastObject).dashes_id];
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:@"取消收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *okAction=[UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SDImageCache sharedImageCache]clearDisk];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];        }
    }
    else if (btn.tag==1)
    {
        
        RemenListItem *item=(RemenListItem *)_dataSource.lastObject;
        
        //分享
        [UMSocialSnsService presentSnsIconSheetView:self
        appKey:@"5632c78867e58eaf3f003965" shareText:item.dashes_name shareImage:[UIImage imageNamed:item.image] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToEmail,UMShareToRenren,UMShareToTencent,nil] delegate:nil];
    }
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0) {
//        [[Database sharedDatabase]insertDataWithRemenListItem:(RemenListItem *)_dataSource.lastObject];
//    }
//}

#pragma  mark  - tableView
-(void)loadTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.height-49)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=145;
    
    [self.view addSubview:_tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ((RemenListItem *)_dataSource.lastObject).stepMutableArray.count;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"做法";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"cell";
    StepTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"StepTableViewCell" owner:self options:nil].lastObject  ;
        
    }
    RemenListItem *item=[_dataSource lastObject];
    [cell setDataWithStepItem:[item.stepMutableArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

 // 准备头视图
-(void)loadHeaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 420)];
    _tableView.tableHeaderView=view;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 300)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:((RemenListItem *)_dataSource.lastObject).image]];
    [view addSubview:imageView];
    
    UIButton *playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame=CGRectMake(ScreenBounds.size.width/2-20, imageView.frame.size.height/2-20, 40, 40);
    [playButton setImage:[UIImage imageNamed:@"love_Play_Icon@2x.png"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:playButton];
    
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, ScreenBounds.size.width, 30)];
    titleLabel.text=((RemenListItem *)_dataSource.lastObject).dashes_name;
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textColor=[UIColor darkGrayColor];
    [view addSubview:titleLabel];
    
    UILabel *descLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 330, ScreenBounds.size.width, 30)];
    descLabel.text=((RemenListItem *)_dataSource.lastObject).material_desc;
    descLabel.font=[UIFont systemFontOfSize:12];
    descLabel.textColor=[UIColor darkGrayColor];
    descLabel.numberOfLines=0;
    [view addSubview:descLabel];
    
    NSArray *array=@[@"难易度@3x.png",@"时长@3x.png",@"口味@3x.png"];
    for (int i=0; i<[array count]; i++) {

        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30+ScreenBounds.size.width/3*i, 360, 20, 20)];
        [imageView setImage:[UIImage imageNamed:array[i]]];
        
        [view addSubview:imageView];
    }
    
    
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenBounds.size.width/3*0, 380, ScreenBounds.size.width/3, 30)];
        label1.text=[NSString stringWithFormat:@"难度:%@        ",((RemenListItem *)_dataSource.lastObject).hard_level];
        label1.font=[UIFont systemFontOfSize:12];
        label1.textColor=[UIColor darkGrayColor];
        label1.textAlignment=NSTextAlignmentCenter;
    
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(ScreenBounds.size.width/3*1, 380, ScreenBounds.size.width/3, 30)];
    label2.text=[NSString stringWithFormat:@"烹饪时间:%@",((RemenListItem *)_dataSource.lastObject).cooking_time];
    label2.font=[UIFont systemFontOfSize:12];
    label2.textColor=[UIColor darkGrayColor];
    label2.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:label1];
    [view addSubview:label2];
    
        
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(ScreenBounds.size.width/3*2, 380, ScreenBounds.size.width/3, 30)];
    label3.text=[NSString stringWithFormat:@"口味:%@",((RemenListItem *)_dataSource.lastObject).taste];
    label3.font=[UIFont systemFontOfSize:12];
    
    label3.textColor=[UIColor darkGrayColor];
    label3.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:label3];
    
    
    
}

//播放视频
-(void)videoPlay
{
   // NSLog(@"111");
    
    MPMoviePlayerViewController *movie1=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:((RemenListItem *)_dataSource.lastObject ).process_video]];
    [self presentMoviePlayerViewControllerAnimated:movie1];

    
    
    
}
#pragma mark - 下载数据
-(void)loadDataSource
{
    //[_activityView stopAnimating];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadDataFinish) name:[NSString stringWithFormat:HOOT_DETAIL_URL,_dishesID] object:nil];
    [[DownLoadManager sharedDownLoadManager]addDownLoadWithDownLoadURL:[NSString stringWithFormat:HOOT_DETAIL_URL,_dishesID] andDownLoadType:5];
    
    
}
-(void)downLoadDataFinish
{
    
    _dataSource=[[DownLoadManager sharedDownLoadManager]getDownLoadDataWithDownLoadURL:[NSString stringWithFormat:HOOT_DETAIL_URL,_dishesID]];
    
    [self performSelectorOnMainThread:@selector(shuaxin) withObject:nil waitUntilDone:NO];
    
    
}
-(void)shuaxin
{
    [_tableView reloadData];
    [self loadHeaderView];
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
