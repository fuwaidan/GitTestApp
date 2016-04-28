//
//  TlistItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "TlistItem.h"

@implementation TlistItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listArray=[[NSMutableArray alloc]init];
        
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
