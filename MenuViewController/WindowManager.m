//
//  WindowManager.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/10.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "WindowManager.h"
#import "WindowImageViewController.h"
#import <objc/runtime.h>

@interface WindowManager (){
    
}
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)WindowImageViewController *imageViewController;
@end
@implementation WindowManager
+(instancetype)manager{
    static WindowManager *manager = nil;
    static dispatch_once_t onceToken;
    if (manager == nil) {
        dispatch_once(&onceToken, ^{
            manager = [[self alloc]init];
            //[manager setUpWindow];
        });
    }
    return manager;
}
- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:CGRectMake(kWidth *0.5, kHeight *0.5, 0, 0)];
        _window.backgroundColor = [UIColor blackColor];
        
    }
    return _window;
}
- (WindowImageViewController *)imageViewController{
    if (!_imageViewController) {
        _imageViewController = [[WindowImageViewController alloc]init];
    }
    return _imageViewController;
}
- (void)setUpWindow{
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:CGRectMake(kWidth *0.5, kHeight *0.5, 0, 0)];
        _window.backgroundColor = [UIColor blackColor];
        
    }
    
}
- (void)showWindowWithMeiZiCategory:(NSString *)categoryTitle withSelectedImageIndex:(NSInteger)selectedIndex{
    //self.imageViewController = [[WindowImageViewController alloc]init];
    NSArray *array  =  objc_getAssociatedObject([WindowManager manager], (__bridge const void *)(categoryTitle));
    self.imageViewController.imageDataArray = [array copy];
    self.imageViewController.currentIndex = selectedIndex;
    self.window.hidden = NO;
    self.window.rootViewController = self.imageViewController;
    self.imageViewController.view.frame = _window.bounds;
    [UIView animateWithDuration:0.5 animations:^{
        self.window.frame = [UIScreen mainScreen].bounds;
    }];
}

- (void)setDismissBlock:(void (^)())dismissBlock{
    dismissBlock();
    self.window.hidden = YES;
    self.imageViewController = nil;
    self.window = nil;
}
@end
