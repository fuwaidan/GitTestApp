//
//  Database.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "Database.h"
#import "FMDatabase.h"
#import "AppUtil.h"
#import "StepItem.h"
@implementation Database
{
    FMDatabase *_fmDatabase;
}


static Database *_sharedDatabase;
+ (Database *)sharedDatabase
{
    if (!_sharedDatabase) {
        _sharedDatabase=[[Database alloc]init];
        
    }
    return _sharedDatabase;
    
}

// 创建数据库
- (void)createDatabase
{
    NSString *path=[NSString stringWithFormat:@"%@demo.db",[AppUtil getCachesPath]];
    _fmDatabase=[[FMDatabase alloc]initWithPath:path];
    if ([_fmDatabase open]) {
//        NSLog(@"数据库创建成功");
    }
    else
    {
        NSLog(@"数据库创建失败");
    }
    [_fmDatabase close];
    
}
//-------------------创建主页ListItem表
-(void)createListItemTable
{
    
    [_fmDatabase open];
    [_fmDatabase executeUpdate:@"create table ListItem(listID text,title text,thumb text,age text,category text,effect text)"];
    
    [_fmDatabase close];
    
}

//插入数据
-(void)insertDataWithListItem:(ListItem *)listItem
{
    if (![self selectDataWithListID:listItem.listID])
    {
        [_fmDatabase open];
        [_fmDatabase executeUpdate:@"insert into ListItem values(?,?,?,?,?,?)",listItem.listID,listItem.title,listItem.thumb,listItem.age,listItem.category,listItem.effect];
        [_fmDatabase close];
        
    }
}
-(BOOL)selectDataWithListID:(NSString *)listID
{
    [_fmDatabase open];
     // 结果集
    FMResultSet *res=[_fmDatabase executeQuery:@"select count(*) from ListItem where listID=?",listID];
    int count=0;
    // 每循环一次代表一行数据
    while ([res next]) {
        
        // 取出当前行对应字段的值
        count=[res intForColumnIndex:0];
    }
    [_fmDatabase close];
    return count;
    
}
//查询数据
-(NSMutableArray *)selectAllListItem
{
    [_fmDatabase open];
    
    FMResultSet *res=[_fmDatabase executeQuery:@"select * from ListItem"];
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    while ([res next])
    {
        ListItem *model=[[ListItem alloc]init];
        model.listID=[res stringForColumn:@"listID"];
        model.title=[res stringForColumn:@"title"];
        model.thumb=[res stringForColumn:@"thumb"];
        model.age=[res stringForColumn:@"age"];
        model.category=[res stringForColumn:@"category"];
        model.effect=[res stringForColumn:@"effect"];
        [dataArray addObject:model];
    }
    [_fmDatabase close];
    
    return dataArray;
}
//删除数据
-(void)deleteListItemWithListID:(NSString *)listID
{
    [_fmDatabase open];
    [_fmDatabase executeUpdate:@"delete from ListItem where listID=?",listID];
    [_fmDatabase close];
}



//---------------------------创建热门和新品表
-(void)createRemenListItemTable
{
    [_fmDatabase open];
    [_fmDatabase executeUpdate:@"create table RmListItem(dashes_id text,image text,hard_level text,dashes_name text,cooking_time text,material_desc text,material_video text,process_video text,taste text)"];//,stepMutableArray text
    
    [_fmDatabase close];
}

-(void)createStepItemTable
{
    [_fmDatabase open];
    [_fmDatabase executeUpdate:@"create table StepItem(dishes_id text,dishes_step_desc text,dishes_step_image text,dishes_step_order text)"];
    [_fmDatabase close];
}
//热门和新品表插入数据
-(void)insertDataWithRemenListItem:(RemenListItem *)rmListItem
{
    
    if (![self selectDataWithRmListID:rmListItem.dashes_id])
    {
        [_fmDatabase open];
        [_fmDatabase executeUpdate:@"insert into RmListItem values(?,?,?,?,?,?,?,?,?)",rmListItem.dashes_id,rmListItem.image,rmListItem.hard_level,rmListItem.dashes_name,rmListItem.cooking_time,rmListItem.material_desc,rmListItem.material_video,rmListItem.process_video,rmListItem.taste];
       
        for (StepItem * step in rmListItem.stepMutableArray) {
            [_fmDatabase executeUpdate:@"insert into StepItem values(?,?,?,?)",step.dishes_id,step.dishes_step_desc,step.dishes_step_image,step.dishes_step_order];
        }
        [_fmDatabase close];
        
    }

}
-(BOOL)selectDataWithRmListID:(NSString *)rmListID
{
    [_fmDatabase open];
    // 结果集
    FMResultSet *res=[_fmDatabase executeQuery:@"select count(*) from RmListItem where dashes_id=?",rmListID];
    int count=0;
    // 每循环一次代表一行数据
    while ([res next]) {
        
        // 取出当前行对应字段的值
        count=[res intForColumnIndex:0];
    }
    [_fmDatabase close];
    return count;
}
//热门和新品表查询数据
-(NSMutableArray *)selectAllRmListItem
{
    [_fmDatabase open];
    
    FMResultSet *res=[_fmDatabase executeQuery:@"select * from RmListItem"];
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    
    while ([res next])
    {
        RemenListItem *model=[[RemenListItem alloc]init];
        model.dashes_id=[res stringForColumn:@"dashes_id"];
        model.image=[res stringForColumn:@"image"];
        model.hard_level=[res stringForColumn:@"hard_level"];
        model.dashes_name=[res stringForColumn:@"dashes_name"];
        model.cooking_time=[res stringForColumn:@"cooking_time"];
        model.material_desc=[res stringForColumn:@"material_desc"];
        model.material_video=[res stringForColumn:@"material_video"];
        model.process_video=[res stringForColumn:@"process_video"];
        model.taste=[res stringForColumn:@"taste"];
       
//        FMResultSet *fmSet2=[_fmDatabase executeQuery:@"select dishes_step_image from StepItem where dishes_id=?",model.dashes_id];
        
//        while ([fmSet2 next]) {
//            NSString *string=[fmSet2 stringForColumn:@"dishes_step_image"];
//            NSString *string1=[fmSet2 stringForColumn:@"dishes_step_desc"];
//            NSString *string2=[fmSet2 stringForColumn:@"dishes_step_order"];
//            NSArray *array=@[string,string1,string2];
//            //[ model.stepMutableArray addObjectsFromArray:array ];
//            
//            [model.stepMutableArray addObject:array];
//            
//            
//        }
        
        [dataArray addObject:model];
    }
    [_fmDatabase close];
    
    return dataArray;
}
//热门和新品表删除数据
-(void)deleteRmListItemWithID:(NSString *)rmListID
{
    [_fmDatabase open];
    [_fmDatabase executeUpdate:@"delete from RmListItem where dashes_id=?",rmListID];
    [_fmDatabase executeUpdate:@"delete from StepItem where dishes_id=?",rmListID];
    
    [_fmDatabase close];
    
}
@end
