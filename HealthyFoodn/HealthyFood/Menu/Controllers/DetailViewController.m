//
//  DetailViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "DetailViewController.h"
#import "MyNavigationItem.h"
#import "InterFace.h"
#import "ListItem.h"
#import "MyTabbar.h"
#import "UMSocial.h"
#import "Database.h"
@interface DetailViewController ()<ALRadialMenuDelegate>
{
    UIWebView *_webView;
    UIButton *_button;
}
@end

@implementation DetailViewController


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
    
    [self loadMyWebView];
    //准备下面的加号按钮
    [self createAddButton];
    
    self.radialMenu=[[ALRadialMenu alloc]init];
    self.radialMenu.delegate=self;
    

}

#pragma mark - 导航条
-(void)loadMyNavigationBar
{
    
    MyNavigationItem *leftItem=[[MyNavigationItem alloc]init];
    leftItem.itemImageName=@"back@2x.png";
    MyNavigationItem *rightItem=[[MyNavigationItem alloc]init];
    rightItem.itemImageName=@"share@2x";
    [self createMyNavigationBarTitle:@"详细做法" andTitleView:nil andLeftItems:@[leftItem] andRightItems:@[rightItem] andSEL:@selector(btnClick:)  andClass:self];
    
    
}
-(void)btnClick:(UIButton *)btn
{
    // NSLog(@"%ld",btn.tag);
    if (btn.tag==1000)
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
    if (btn.tag==2000)
    {
        //563183b7e0f55a0933003a39
        ListItem *item=[_dataArray objectAtIndex:_currentID];
        [UMSocialSnsService presentSnsIconSheetView:self
        appKey:@"5632c78867e58eaf3f003965" shareText:item.title shareImage:[UIImage imageNamed:@"AppIcon29x29@2x.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToEmail,UMShareToRenren,UMShareToTencent,nil] delegate:nil];
    }
}


#pragma mark - 加号按钮
-(void)createAddButton
{
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(0, ScreenBounds.size.height-50, 30, 30);
    [_button setBackgroundImage:[UIImage imageNamed:@"addthis500.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
    
}
-(void)buttonClick:(UIButton *)btn
{
    //调用旋转按钮
    [self.radialMenu buttonsWillAnimateFromButton:btn inView:self.view];
    
}

// 我们需要设置的协议方法
#pragma mark - radial menu delegate methods
// 设置弹出小球的数量

-(NSInteger)numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu
{
    if (radialMenu==self.radialMenu) {
        return 3;
    }
    return 0;
}

//设置起始角度
-(NSInteger)arcStartForRadialMenu:(ALRadialMenu *)radialMenu
{
    return -60;
}
//所有小球旋转的角度
-(NSInteger)arcSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    if (radialMenu==self.radialMenu) {
        return 90;
    }
    return 0;
}
//距离圆心按钮的半径
-(NSInteger)arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu
{
    if (self.radialMenu==self.radialMenu) {
        return 60;
    }
    return 0;
}
//设置每个按钮的图片
-(UIImage *)radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger)index
{
    if (radialMenu==self.radialMenu)
    {
        if (index==1) {
            return [UIImage imageNamed:@"love_upPlay_Icon@2x"];
        }
        else if (index==2){
            
            return [UIImage imageNamed:@"loved@2x"];
        }
        else if (index==3){
            return [UIImage imageNamed:@"love_Play_Icon@2x.png"];
        }
    }
    return nil;
}

//按钮的点击事件
-(void)radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index
{
    //    if (radialMenu==self.radialMenu) {
    //        [self.radialMenu itemsWillDisapearIntoButton:_button];
    //    }
    if (index==1) {
        if (_currentID-1>=0)
        {
            _currentID=_currentID-1;
            [self webViewLoadData];
        }
    }
    else if (index==2)
    {
        //return [UIImage imageNamed:@"favorite-icon@2x"];
        [[Database sharedDatabase]insertDataWithListItem:[_dataArray objectAtIndex:_currentID]];
        
    }
    else if (index==3)
    {
        if (_currentID+1<_dataArray.count) {
            _currentID=_currentID+1;
            [self webViewLoadData];
        }
    }
}
#pragma mark - loadWebView

-(void)loadMyWebView
{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenBounds.size.width, ScreenBounds.size.height-64)];
    [self.view addSubview:_webView];
    
    [self webViewLoadData];
    
    
}

-(void)webViewLoadData
{
    
    ListItem *item=[_dataArray objectAtIndex:_currentID];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:LIST_DETAIL_URL,item.listID]];
    
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
