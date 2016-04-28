//
//  MenuItem.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property(nonatomic,strong)NSString *detailID;
@property(nonatomic,strong)NSString *jianjie;
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSMutableArray *tlistArray;
@end
