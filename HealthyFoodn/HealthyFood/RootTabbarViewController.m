//
//  RootTabbarViewController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "RootTabbarViewController.h"
#import "RootViewController.h"

#import "MyTabbar.h"

@interface RootTabbarViewController ()

@end

@implementation RootTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSArray *viewControllerTitles = @[@"TopViewController",@"FindViewController",@"ZhuanTiViewController",@"MenuViewController"];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    for(NSString *title in viewControllerTitles)
    {
        RootViewController *vc = [[NSClassFromString(title) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [vcArray addObject:nav];
    }
    
    self.viewControllers=vcArray;
    
    MyTabbar *myTabbar = [MyTabbar sharedMyTabbar];
    myTabbar.tabbarController = self;
    [self.view addSubview:myTabbar];
    

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
