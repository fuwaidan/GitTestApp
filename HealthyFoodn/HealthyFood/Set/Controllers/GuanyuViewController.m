//
//  GuanyuViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "GuanyuViewController.h"
#import "InterFace.h"
@interface GuanyuViewController ()

@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
    
}


-(void)configUI
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, ScreenBounds.size.height)];
    imageView.image=[UIImage imageNamed:@"lunch.png"];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    UIImageView *logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenBounds.size.width, 300)];
    logoImage.image=[UIImage imageNamed:@"Logo@2x.png"];
    
    logoImage.userInteractionEnabled=YES;
    [imageView addSubview:logoImage];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 320, ScreenBounds.size.width-20*2, 200)];
    label.numberOfLines=0;
    label.text=@"爱尚美食是全球最大的中文美食网站,每年有超过2亿人使用我们的服务.爱尚美食客户端将秉承我们让吃更美好的使命,让大家在指尖发现 分享天下美食,以及吃货们才懂的喜悦.";
    label.textColor=[UIColor lightGrayColor];
    [imageView addSubview:label];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 20, 30, 30);
    [button setImage:[UIImage imageNamed:@"详情返回@2x.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoImage addSubview:button];
    
}

-(void)buttonClick:(UIButton *)btn
{
    NSLog(@"ff");
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
