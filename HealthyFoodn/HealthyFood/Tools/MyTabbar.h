//
//  MyTabbar.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabbar : UIView

+(MyTabbar *)sharedMyTabbar;
@property(nonatomic,strong)UITabBarController *tabbarController;
@end