//
//  GudicanceController.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "GudicanceController.h"

@interface GudicanceController ()

@end

@implementation GudicanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}

- (void)createScrollView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    
    scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 3, CGRectGetHeight([UIScreen mainScreen].bounds));
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50 + CGRectGetWidth([UIScreen mainScreen].bounds) * i, 50, CGRectGetWidth([UIScreen mainScreen].bounds) - 100, CGRectGetHeight([UIScreen mainScreen].bounds) - 100)];
        UIImage * image  =[UIImage imageNamed:[NSString stringWithFormat:@"heh%d.png", i+1]];
        
        imageView.image = image;
        
        [scrollView addSubview:imageView];
        
        
    }
    
    //开启翻页模式
    scrollView.pagingEnabled = YES;
    //设置代理

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(3 * CGRectGetWidth([UIScreen mainScreen].bounds) - 300, CGRectGetHeight([UIScreen mainScreen].bounds) -40, CGRectGetWidth([UIScreen mainScreen].bounds) - 150, 30)];
    button.layer.borderWidth = 2;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.cornerRadius = 5;
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor redColor].CGColor;
    [scrollView addSubview:button];
    
    [self.view addSubview:scrollView];
    


}

- (void)onClick {

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:1 forKey:@"IS_SHOW_GUIDANCE"];
    [user synchronize];
    self.block();
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
