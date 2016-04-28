//
//  ListItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"ID"]) {
        _listID=value;
        
    }
}
@end
