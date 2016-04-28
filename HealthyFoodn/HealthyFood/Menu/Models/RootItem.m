//
//  RootItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "RootItem.h"

@implementation RootItem
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"ID"]) {
        _resultsID=value;
    }
}
@end
