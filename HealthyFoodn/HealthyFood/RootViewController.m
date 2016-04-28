//
//  RootViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "MyNavigationItem.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

- (void)createMyNavigationBarTitle:(NSString *)title andTitleView:(UIView *)view andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)rightItems andSEL:(SEL)sel andClass:(id)classObject
{
    MyNavigationBar *myNavigationBar = [[MyNavigationBar alloc] initWithClass:classObject andSEL:sel];
    
    myNavigationBar.navigationTitle = title;
    myNavigationBar.navigationTitleView = view;
    myNavigationBar.leftItems = leftItems;
    myNavigationBar.rightItems = rightItems;
    
    [self.view addSubview:myNavigationBar];
    
    
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
