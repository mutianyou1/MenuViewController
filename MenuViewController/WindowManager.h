//
//  WindowManager.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/10.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WindowManager : NSObject
+(instancetype)manager;
- (void)showWindowWithMeiZiCategory:(NSString*)categoryTitle withSelectedImageIndex:(NSInteger)selectedIndex;
- (void)setDismissBlock:(void(^)())dismissBlock;
@end
