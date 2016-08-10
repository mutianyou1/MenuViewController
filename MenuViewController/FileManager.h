//
//  FileManager.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/9.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
+(instancetype)manager;
- (BOOL)saveJasonToDisk:(id)data pathKey:(NSString*)key;
- (id)getJasonFromFileWithTitle:(NSString*)title;
@end
