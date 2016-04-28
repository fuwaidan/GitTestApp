//
//  MenuItem.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tlistArray=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"ID"]) {
        _detailID=value;
    }
}
@end
