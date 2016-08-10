//
//  FileManager.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/9.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "FileManager.h"

@implementation FileManager
+(instancetype)manager{
    static  FileManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (manager == nil) {
            manager = [[self alloc]init];
        }
    });
    return manager;
}
- (BOOL)saveJasonToDisk:(id)data pathKey:(NSString*)key{
    NSError *erro = nil;
    NSData *saveData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&erro];
    if (erro) {
        NSLog(@"%@",erro.userInfo);
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPathWithKey:key]]) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] createFileAtPath:[self getPathWithKey:key] contents:saveData attributes:nil];
}
- (NSString*)getPathWithKey:(NSString*)key{
    
   
    
    return [NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject],key];
}
- (id)getJasonFromFileWithTitle:(NSString *)title{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:[self getPathWithKey:title] options:NSDataReadingMapped error:&error];
    if (error) {
        NSLog(@"%@",error.userInfo);
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

}
@end
