//
//  ZhuantiItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZhuantiItem.h"

@implementation ZhuantiItem


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID=value;
    }
    else if ([key isEqualToString:@"description"])
    {
        _descrip=value;
        
    }
}
@end
