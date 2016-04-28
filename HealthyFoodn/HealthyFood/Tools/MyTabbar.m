//
//  MyTabbar.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "MyTabbar.h"
#import "InterFace.h"
@implementation MyTabbar

{
    UITabBarController *_tbc;
}
static MyTabbar *_sharedMyTabbar;
+(MyTabbar *)sharedMyTabbar
{
    if (!_sharedMyTabbar) {
        _sharedMyTabbar=[[MyTabbar alloc]init];
        _sharedMyTabbar.frame=CGRectMake(0, ScreenBounds.size.height-64, ScreenBounds.size.width, 64);
        _sharedMyTabbar.backgroundColor=[UIColor colorWithRed:236/255.0 green:40/255.0 blue:73/255.0 alpha:1.00f];
    }
    return _sharedMyTabbar;
    
    
}
-(void)setTabbarController:(UITabBarController *)tabbarController
{
    [self createMyTabbar];
    _tbc=tabbarController;  
    
}
-(void)createMyTabbar
{
    
    NSDictionary *plistDict=[[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/MyTabbar.plist",[[NSBundle mainBundle]resourcePath]]];
    int index=0;
    for (NSDictionary *itemDict in [plistDict objectForKey:@"items"]) {
        [self createItemWithItemDict:itemDict andIndex:index andCount:(int)[[plistDict objectForKey:@"items"]count]];
        index++;
    }
    [self selectItemWithIndex:0];
}
-(void)createItemWithItemDict:(NSDictionary *)itemDict andIndex:(int)index andCount:(int)count
{
    // 容器
    UIView *baseView = [[UIView alloc] init];
    baseView.frame = CGRectMake(self.bounds.size.width/count*index, 0, self.bounds.size.width/count, 64);
    baseView.tag = index+2000;
    [self addSubview:baseView];
    
    // 设计模式 23 27 (工厂模式)
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, baseView.frame.size.width, baseView.frame.size.height*2/3);
    
    
    [btn setImage:[UIImage imageNamed:[itemDict objectForKey:@"imagename"]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[itemDict objectForKey:@"selectimagename"]] forState:UIControlStateSelected];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = index;
    [baseView addSubview:btn];
    
    // UILabel
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, btn.frame.size.height, baseView.frame.size.width, baseView.frame.size.height*1/3);
    label.text = [itemDict objectForKey:@"title"];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    [baseView addSubview:label];
}
-(void)selectItemWithIndex:(int)index
{
    // 将所有的变为未选中状态
    for(UIView *view in self.subviews)
    {
        if(view.tag != 1001)
        {
            ((UIButton *)[view.subviews objectAtIndex:0]).selected = NO;
            ((UILabel *)[view.subviews objectAtIndex:1]).textColor = [UIColor whiteColor];
        }
    }
    // 变成选中状态
    UIView *baseView = [self viewWithTag:index+2000];
    ((UIButton *)[baseView.subviews objectAtIndex:0]).selected = YES;
    ((UILabel *)[baseView.subviews objectAtIndex:1]).textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:85/255.0 alpha:1.00f];;
}
-(void)btnClick:(UIButton *)btn
{
    // 1.切换界面
    _tbc.selectedIndex = btn.tag;
    // 2.修改假UI颜色
    [self selectItemWithIndex:(int)btn.tag];
}
@end
