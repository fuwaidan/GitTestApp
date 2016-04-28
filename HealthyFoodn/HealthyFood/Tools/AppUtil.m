//
//  AppUtil.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil
+ (NSString *)getCachesPath
{
    return [NSString stringWithFormat:@"%@/Library/Caches/",NSHomeDirectory()];
}
@end
