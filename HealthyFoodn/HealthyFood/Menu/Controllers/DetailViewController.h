//
//  DetailViewController.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "RootViewController.h"
#import "ALRadialMenu.h"
@interface DetailViewController : RootViewController



@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)int currentID;

@property(nonatomic,strong)ALRadialMenu *radialMenu;

@end
