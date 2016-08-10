//
//  ImageDataTool.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/9.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageData : NSObject
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *group_url;
@property (nonatomic,strong)NSString *image_url;
@property (nonatomic,strong)NSString *objectId;
@property (nonatomic,strong)NSString *thumb_url;
@property (nonatomic,strong)NSString *title;
+(NSArray*)getImageDataItemWithDictionary:(NSDictionary*)dict;
@end
