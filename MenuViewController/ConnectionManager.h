//
//  ConnectionManager.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,MeiZiCategory){
   MeiZiCategoryALL = 0,
   MeiZiCategoryDaXiong,
   MeiZiCategoryQiaoTun,
   MeiZiCategoryHeiSi,
   MeiZiCategoryMeiTui,
   MeiZiCategoryQingXin,
   MeiZiCategoryZaHui
};
@interface ConnectionManager : NSObject

+(ConnectionManager*)manager;
/**
 一般网络请求写法
 */
//- (void)requestWithPath:(NSString*)path paramaters:(NSDictionary*)dict success:(void (^)( id  responseObject))success failure:(void (^) (NSError * error))failure;

- (void)requestWithMeiZiCategory:(MeiZiCategory)category page:(NSString*)page progress:(void (^)(NSProgress * progress))download success:(void (^)( id  responseObject))success failure:(void (^) (NSError *  error))failure;
@end
