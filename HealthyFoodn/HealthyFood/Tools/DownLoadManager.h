//
//  DownLoadManager.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DownLoad.h"
@interface DownLoadManager : NSObject<DownLoadDelegate>
+ (DownLoadManager *)sharedDownLoadManager;
// 添加下载任务
- (void)addDownLoadWithDownLoadURL:(NSString *)downLoadURL andDownLoadType:(int)downLoadType;
// 取得下载数据
- (NSMutableArray *)getDownLoadDataWithDownLoadURL:(NSString *)downLoadURL;
@end
