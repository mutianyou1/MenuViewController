//
//  ViewController.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/5.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ViewController.h"
#import "MenuVC.h"
#import "MeiZiCollectionViewController.h"
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
    MeiZiCollectionViewController *vc1 = [[MeiZiCollectionViewController alloc]initWithCollectionViewLayout:[self defaultLayout]];
    MeiZiCollectionViewController *vc2 = [[MeiZiCollectionViewController alloc]initWithCollectionViewLayout:[self defaultLayout]];
    MeiZiCollectionViewController *vc3 = [[MeiZiCollectionViewController alloc]initWithCollectionViewLayout:[self defaultLayout]];
    MeiZiCollectionViewController *vc4 = [[MeiZiCollectionViewController alloc]initWithCollectionViewLayout:[self defaultLayout]];
    
    vc1.title = @"气质";
    vc2.title = @"有料";
    vc3.title = @"内涵";
    vc4.title = @"胸器";
    
    vc1.category = MeiZiCategoryQingXin;
    vc2.category = MeiZiCategoryZaHui;
    vc3.category = MeiZiCategoryHeiSi;
    vc4.category = MeiZiCategoryDaXiong;
    
    MenuVC *menu = [[MenuVC alloc]initWithViewControllers:@[vc1,vc2,vc3,vc4]];
    [self.view addSubview:menu.view];
    [self addChildViewController:menu];
    [menu didMoveToParentViewController:self];
}
- (UICollectionViewFlowLayout*)defaultLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(110*kHeightScale, 130*kHeightScale);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
