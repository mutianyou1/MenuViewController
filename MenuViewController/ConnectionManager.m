//
//  ConnectionManager.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ConnectionManager.h"
#import <AFNetworking.h>
#import <AFURLSessionManager.h>
static ConnectionManager *manager = nil;
static const NSString *baseURL = @"http://meizi.leanapp.cn/category";
@implementation ConnectionManager
+ (ConnectionManager*)manager{
    if (manager == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
           manager = [[self alloc]init];
        });
        
    }
    return manager;

}
//http://meizi.leanapp.cn/category/All/page/10
// http://meizi.leanapp.cn/category/DaXiong/page/10
- (void)requestWithMeiZiCategory:(MeiZiCategory)category page:(NSString*)page success:(void (^)( id  responseObject))success failure:(void (^) (NSError *  error))failure {
    
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    
    NSString *categoryString = @"All";
    
    switch (category) {
     case MeiZiCategoryALL:
     categoryString = @"All";
     break;
     case MeiZiCategoryDaXiong:
     categoryString = @"DaXiong";
     break;
     case MeiZiCategoryQiaoTun:
     categoryString = @"QiaoTun";
     break;
     case MeiZiCategoryHeiSi:
     categoryString = @"HeiSi";
     break;
     case MeiZiCategoryMeiTui:
     categoryString = @"MeiTui";
     break;
     case MeiZiCategoryQingXin:
     categoryString = @"QingXin";
     break;
     case MeiZiCategoryZaHui:
     categoryString = @"ZaHui";
     break;
     default:
     categoryString = @"All";
     break;
     }
    
    [httpManager POST:[NSString stringWithFormat:@"%@/%@/page/%@",baseURL,categoryString,page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
@end
