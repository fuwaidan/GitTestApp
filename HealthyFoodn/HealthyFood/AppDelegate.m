//
//  AppDelegate.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabbarViewController.h"
#import "UMSocial.h"
#import "Database.h"
#import "YRSideViewController.h"
#import "SetViewController.h"
#import "GudicanceController.h"
//#import "UMSocialQQHandler.h"






@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [[Database sharedDatabase]createDatabase];
    [[Database sharedDatabase]createListItemTable];
    
    [[Database sharedDatabase]createRemenListItemTable];
    [[Database sharedDatabase]createStepItemTable];
    
    
    NSLog(@"........%@",[NSString stringWithFormat:@"%@/Library/Caches/",NSHomeDirectory()]);
    
    
    // 设置友盟AppKey
    
    [UMSocialData setAppKey:@"5632c78867e58eaf3f003965"];
    
//    
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    [UMSocialQQHandler setSupportWebView:YES];
    
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    NSInteger flag = [userDef integerForKey:@"IS_SHOW_GUIDANCE"];
    
    _window.rootViewController = flag?[self createSideViewController]:[self createGudicanceController];

    
    
    
    
//    NSString *sitrng = [@"家常菜" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"t-tttttttttt-------------%@",sitrng);
    
    return YES;
}

- (YRSideViewController *)createSideViewController {
    
    //初始化一个抽屉对象
    YRSideViewController *sideViewController = [[YRSideViewController alloc] init];
    
    //设置中间视图
    sideViewController.rootViewController=[[RootTabbarViewController alloc]init];
    //设置右边视图
    sideViewController.rightViewController=[[SetViewController alloc]init];
    [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect                                                 orginFrame, CGFloat xoffset) {
        
        rootView.frame = CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    
    //自定义抽屉左右视图宽度
    sideViewController.rightViewShowWidth = 250;
    
    self.window.rootViewController = sideViewController;
    
    return sideViewController;

}

- (GudicanceController *)createGudicanceController {

    MyBlock block = ^(void){
        
        //回调的之后  修改根控制器为tabBarController
        self.window.rootViewController = [self createSideViewController];
        
        
    };
    
    GudicanceController * guvc = [[GudicanceController alloc] init];
    
    guvc.block = block;
    
    return guvc;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
