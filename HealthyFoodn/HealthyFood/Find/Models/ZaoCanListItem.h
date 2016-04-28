//
//  ZaoCanListItem.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZaoCanListItem : NSObject


@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *cooking_time;
@property(nonatomic,strong)NSString *taste;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger likes;
@property(nonatomic,strong)NSString *thumbnail;

@end
