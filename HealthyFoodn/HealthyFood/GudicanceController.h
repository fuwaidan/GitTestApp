//
//  GudicanceController.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//
typedef void(^MyBlock)(void);

#import <UIKit/UIKit.h>

@interface GudicanceController : UIViewController

@property (nonatomic, copy)MyBlock block;

@end
