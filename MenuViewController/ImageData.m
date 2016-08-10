//
//  ImageDataTool.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/9.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ImageData.h"

@implementation ImageData

+(NSArray *)getImageDataItemWithDictionary:(NSDictionary *)dict{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *imagesData in dict) {
        ImageData *data = [[ImageData alloc]init];
        [data setValuesForKeysWithDictionary:imagesData];
        [array addObject:data];
    }


    return [array copy];
}
@end
