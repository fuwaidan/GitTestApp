//
//  RemenListItem.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemenListItem : NSObject

@property(nonatomic,strong)NSString *dashes_id;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *hard_level;
@property(nonatomic,strong)NSString *dashes_name;
@property(nonatomic,strong)NSString *cooking_time;
@property(nonatomic,strong)NSString *material_desc;
@property(nonatomic,strong)NSString *material_video;
@property(nonatomic,strong)NSString *process_video;
@property(nonatomic,strong)NSMutableArray *stepMutableArray;
@property(nonatomic,strong)NSString *taste;

@end
