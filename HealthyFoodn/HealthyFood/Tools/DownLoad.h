//
//  DownLoad.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownLoad;
@protocol DownLoadDelegate <NSObject>
- (void)downLoadFinishWithDownLoad:(DownLoad *)downLoad;
@end
@interface DownLoad : NSObject<NSURLSessionDataDelegate>

@property(nonatomic,strong)NSString *downLoadURL;
@property(nonatomic,assign)int downLoadType;
// 用来存储下载完的二进制数据
@property(nonatomic,strong)NSMutableData *downLoadData;
@property(nonatomic,weak)id<DownLoadDelegate> delegate;

- (void)downLoadStart;


@end
