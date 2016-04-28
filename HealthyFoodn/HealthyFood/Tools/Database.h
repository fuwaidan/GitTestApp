//
//  Database.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ListItem.h"
#import "RemenListItem.h"
@interface Database : NSObject


+ (Database *)sharedDatabase;

// 创建数据库
- (void)createDatabase;
//创建ListItem表
-(void)createListItemTable;

//插入数据
-(void)insertDataWithListItem:(ListItem *)listItem;
//查询数据
-(NSMutableArray *)selectAllListItem;
//删除数据
-(void)deleteListItemWithListID:(NSString *)listID;

//创建热门和新品表
-(void)createRemenListItemTable;

-(void)createStepItemTable;

//插入数据
-(void)insertDataWithRemenListItem:(RemenListItem *)rmListItem;
//查询数据
-(NSMutableArray *)selectAllRmListItem;

-(BOOL)selectDataWithRmListID:(NSString *)rmListID;
//删除数据
-(void)deleteRmListItemWithID:(NSString *)rmListID;

@end
