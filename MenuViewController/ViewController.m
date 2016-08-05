//
//  ViewController.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/5.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ViewController.h"
#import "MenuVC.h"
//229 45 118
@interface ViewController ()

@end

@implementation ViewController
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美女";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = kPinkColor;
    UIViewController *vc1 = [[UIViewController alloc]init];
    UIViewController *vc2 = [[UIViewController alloc]init];
    UIViewController *vc3 = [[UIViewController alloc]init];
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc1.title = @"有料";
    vc2.title = @"内涵";
    vc3.title = @"气质";
    vc4.title = @"胸器";
    vc1.view.backgroundColor = [UIColor yellowColor];
    vc2.view.backgroundColor = [UIColor brownColor];
    vc3.view.backgroundColor = [UIColor greenColor];
    vc4.view.backgroundColor = [UIColor redColor];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40 + 64*kHeightScale, self.view.bounds.size.height, self.view.bounds.size.height - 40 - 60*kHeightScale)];
    view1.backgroundColor = [UIColor yellowColor];
    [vc1.view addSubview:view1];
    view1.backgroundColor = [UIColor brownColor];
    [vc2.view addSubview:view1];
    view1.backgroundColor = [UIColor greenColor];
    [vc3.view addSubview:view1];
    view1.backgroundColor = [UIColor greenColor];
    [vc4.view addSubview:view1];
    MenuVC *menu = [[MenuVC alloc]initWithViewControllers:@[vc1,vc2,vc3,vc4]];
    [self.view addSubview:menu.view];
    [self addChildViewController:menu];
    [menu didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
