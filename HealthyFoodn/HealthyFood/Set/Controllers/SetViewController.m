//
//  SetViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "SetViewController.h"
#import "InterFace.h"
#import "LoginViewController.h"
#import "SaveViewController.h"
#import "GuanyuViewController.h"
#import "UIImageView+WebCache.h"
@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    UITableView *_tableView;
    
    NSArray *_titleArray;
    NSArray *_imageArray;
    
    
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadTableView];
    
    [self loadHeaderView];
    
    _titleArray=@[@"我的收藏",@"关于我们",@"清除缓存"];
   _imageArray=@[@"my_favs.png",@"my_recipe.png",@"my_draft.png"];
    
    
}

#pragma mark -  loadHeaderView

-(void)loadHeaderView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(ScreenBounds.size.width-250, 0, 250, 250)];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
    
    imageView.image=[UIImage imageNamed:@"login_box_bg4.png"];
    [view addSubview:imageView];
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame=CGRectMake((ScreenBounds.size.width-(ScreenBounds.size.width-250))/2-45, imageView.frame.size.height/2-40, 90, 80);
//    
//    //button.backgroundColor=[UIColor redColor];
//    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:button];
    
    _tableView.tableHeaderView=view;
    
}

-(void)buttonClick:(UIButton *)btn
{
    // NSLog(@"ggg");
//    LoginViewController *login=[[LoginViewController alloc]init];
//    
//    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark - loadTableView

-(void)loadTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenBounds.size.width-250, 0, 250, ScreenBounds.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor colorWithRed:0.96f green:0.95f blue:0.91f alpha:1.00f];
    
    
    [self.view addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName] ;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    
    cell.textLabel.text=_titleArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.imageView.image=[UIImage imageNamed:_imageArray[indexPath.row]];
    
    if (indexPath.row==3) {
        cell.detailTextLabel.text=@"V4.0.1";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"     ";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        SaveViewController *save=[[SaveViewController alloc]init];
//        [self.navigationController pushViewController:save animated:YES];
        
        [self presentViewController:save animated:YES completion:nil];
    }
    else if (indexPath.row==1)
    {
        GuanyuViewController *guanyu=[[GuanyuViewController alloc]init];
        
        [self presentViewController:guanyu animated:YES completion:nil];
        
    }else if (indexPath.row==2)
    {
       
        NSInteger  byteSize=[SDImageCache sharedImageCache].getSize ;
        double size=byteSize/1000.0/1000.0;
        self.title=[NSString stringWithFormat:@"缓存大小（%.1fm）",size];
        
        UIAlertController *alertController=[UIAlertController
        alertControllerWithTitle:@"清除缓存" message:self.title preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction=[UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
   
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
