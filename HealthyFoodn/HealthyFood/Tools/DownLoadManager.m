//
//  DownLoadManager.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "DownLoadManager.h"
#import "MenuItem.h"
#import "RootItem.h"
#import "TlistItem.h"
#import "ListItem.h"
#import "Remenitem.h"
#import "ZhuantiItem.h"
#import "RemenListItem.h"
#import "ZhuantiListItem.h"
#import "StepItem.h"
#import "ResultItem.h"
#import "RecipeItem.h"
#import "ZaoCanItem.h"
#import "ZaoCanListItem.h"
@implementation DownLoadManager
{
    // 下载任务队列
    NSMutableDictionary *_taskDict;
    // 数据缓存队列
    NSMutableDictionary *_sourceDict;
}



static DownLoadManager *_sharedDownLoadManager;

+ (DownLoadManager *)sharedDownLoadManager
{
    if(!_sharedDownLoadManager)
    {
        _sharedDownLoadManager = [[DownLoadManager alloc] init];
    }
    return _sharedDownLoadManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskDict = [[NSMutableDictionary alloc] init];
        _sourceDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)addDownLoadWithDownLoadURL:(NSString *)downLoadURL andDownLoadType:(int)downLoadType
{
    if([_sourceDict objectForKey:downLoadURL])
    {
        // 有缓存,直接通知界面可以取得数据
        [[NSNotificationCenter defaultCenter] postNotificationName:downLoadURL object:nil];
    }
    else
    {
        if([_taskDict objectForKey:downLoadURL])
        {
//            NSLog(@"当前下载任务已经在下载，无需重复下载");
        }
        else
        {
            // 实例化下载对象进行下载数据
            DownLoad *dl = [[DownLoad alloc] init];
            dl.downLoadURL = downLoadURL;
            dl.downLoadType = downLoadType;
            dl.delegate = self;
            [dl downLoadStart];
            [_taskDict setObject:dl forKey:downLoadURL];
            
        }
    }
}

- (void)downLoadFinishWithDownLoad:(DownLoad *)downLoad
{
    // 1.从下载队列中移除对象
    [_taskDict removeObjectForKey:downLoad.downLoadURL];
    // 2.解析数据
    // 用于装载解析好的数据模型对象
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
   
    if (downLoad.downLoadType==1)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSArray *resultsArray=[JSONDict objectForKey:@"results"];
        for (NSDictionary *dic in resultsArray) {
            RootItem *item=[[RootItem alloc]init];
            [item setValuesForKeysWithDictionary:dic];
            [dataArray addObject:item];
        }
    }
    else if (downLoad.downLoadType==2)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        
        MenuItem *menuItem=[[MenuItem alloc]init];
        [menuItem setValuesForKeysWithDictionary:JSONDict];
        for (NSDictionary *dic in [JSONDict objectForKey:@"tlist"]) {
            TlistItem *item=[[TlistItem alloc]init];
            [item setValuesForKeysWithDictionary:dic];
            for (NSDictionary *dict in dic[@"list"]) {
                ListItem *listItem=[[ListItem alloc]init];
                [listItem setValuesForKeysWithDictionary:dict];
                [item.listArray addObject:listItem];
            }
            [menuItem.tlistArray addObject:item];
        }
        [dataArray addObject:menuItem];
      
    
    }
    else if (downLoad.downLoadType==3)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dictionary=[JSONDict objectForKey:@"data"];
        NSArray *array=[dictionary objectForKey:@"data"];
        for (NSDictionary *dict in array)
        {
            Remenitem *item=[[Remenitem alloc]init];
            [item setValuesForKeysWithDictionary:dict];
            [dataArray addObject:item];
            
        }
        
    }
    else if (downLoad.downLoadType==4)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDictionary=[JSONDict objectForKey:@"data"];
        NSArray *array=[dataDictionary objectForKey:@"data"];
        for (NSDictionary *dict in array)
        {
            ZhuantiItem *item=[[ZhuantiItem alloc]init];
            [item setValuesForKeysWithDictionary:dict];
            
            [dataArray addObject:item];
            
        }
    }
    else if (downLoad.downLoadType==5)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dictionary=[JSONDict objectForKey:@"data"];
        RemenListItem *item=[[RemenListItem alloc]init];
        [item setValuesForKeysWithDictionary:dictionary];
        
        for (NSDictionary *dic in dictionary[@"step"])
        {
            StepItem *stepItem=[[StepItem alloc]init];
            [stepItem setValuesForKeysWithDictionary:dic];
            
            [item.stepMutableArray addObject:stepItem];
        }
    
        [dataArray addObject:item];
        
    }
    
    else if (downLoad.downLoadType==6)
    {
         NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
         NSDictionary *dictionary=[JSONDict objectForKey:@"data"];
        ZhuantiListItem *item=[[ZhuantiListItem alloc]init];
        [item setValuesForKeysWithDictionary:dictionary];
        [dataArray addObject:item];
        
    }
    
    else if (downLoad.downLoadType==7)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dictionary=[JSONDict objectForKey:@"result"];
        ResultItem *resultItem=[[ResultItem alloc]init];
        [resultItem setValuesForKeysWithDictionary:dictionary];
        
        NSDictionary *recipeDict=[dictionary objectForKey:@"recipe"];
        for (NSDictionary *dict in recipeDict[@"list"])
        {
            RecipeItem *recipeItem=[[RecipeItem alloc]init];
            [recipeItem setValuesForKeysWithDictionary:dict];
            [resultItem.recipeArray addObject:recipeItem];
        }

        [dataArray addObject:resultItem];
    }
    
    else if (downLoad.downLoadType==8)
    {
         NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSArray *linksArray=[JSONDict objectForKey:@"links"];
        for (NSDictionary *di in linksArray)
        {
            ZaoCanItem *zaoCan=[[ZaoCanItem alloc]init];
            [zaoCan setValuesForKeysWithDictionary:di];
            [dataArray addObject:zaoCan];
            
        }
        
    }
    else if (downLoad.downLoadType==9)
    {
        NSDictionary *JSONDict=[NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *zcList in JSONDict[@"result"]) {
            ZaoCanListItem *zcListItem=[[ZaoCanListItem alloc]init];
            [zcListItem setValuesForKeysWithDictionary:zcList];
            [dataArray addObject:zcListItem];
            
        }
        
    }
    
    // 3.存储缓存
    [_sourceDict setObject:dataArray forKey:downLoad.downLoadURL];
    
    // 4.通知界面下载数据、解析、缓存完成，可以取得数据
    [[NSNotificationCenter defaultCenter] postNotificationName:downLoad.downLoadURL object:nil];
}

- (NSMutableArray *)getDownLoadDataWithDownLoadURL:(NSString *)downLoadURL
{
    return [_sourceDict objectForKey:downLoadURL];
}


@end
