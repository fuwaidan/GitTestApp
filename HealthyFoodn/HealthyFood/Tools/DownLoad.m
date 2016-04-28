//
//  DownLoad.m
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//

#import "DownLoad.h"

@implementation DownLoad


- (void)downLoadStart
{
    NSURL *url = [NSURL URLWithString:_downLoadURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        _downLoadData = [NSMutableData dataWithData:data];
        [_delegate downLoadFinishWithDownLoad:self];
    }];
    
    [sessionDataTask resume];
    
    
}

@end
