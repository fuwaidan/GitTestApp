//
//  ZhuantiListItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ZhuantiListItem.h"

@implementation ZhuantiListItem
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID=value;
    }
}
@end
