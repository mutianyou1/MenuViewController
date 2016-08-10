//
//  MenuVC.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/5.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "MenuVC.h"
#import "MenuTitleItem.h"
static const CGFloat kItemHeight = 40.0;
static const CGFloat kNaviHeigth = 64.0;
@interface MenuVC ()<UIScrollViewDelegate>{
    NSArray *_viewControllers;
    UIView *_bottomTipsView;
    NSInteger _currentIndex;
}
@property (nonatomic,strong)UIScrollView *menuScrollView;
@property (nonatomic,strong)UIScrollView *controllerScrollView;
@property (nonatomic,assign)BOOL isControllerScrolling;
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIScrollView *)menuScrollView{
    if (!_menuScrollView) {
        _menuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kItemHeight*kHeightScale - 3 + kNaviHeigth, self.view.bounds.size.width, 2)];
        _menuScrollView.delegate = self;
        _menuScrollView.backgroundColor = [UIColor clearColor];
        _menuScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 0);
    }
    return _menuScrollView;
}
- (UIScrollView *)controllerScrollView{
    if (!_controllerScrollView) {
        _controllerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNaviHeigth + kItemHeight *kHeightScale, self.view.bounds.size.width, self.view.bounds.size.height - kNaviHeigth - kItemHeight*kHeightScale)];
        _controllerScrollView.delegate = self;
        _controllerScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _viewControllers.count, 0);
        _controllerScrollView.pagingEnabled = YES;
        _controllerScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _controllerScrollView;
}
- (instancetype)initWithViewControllers:(NSArray *)viewControllers{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithRed:245/256.0 green:245/256.0 blue:245/256.0 alpha:1.0];
        _viewControllers = [[NSArray alloc]initWithArray:viewControllers];
        _currentIndex = 0;
        [self setUpMenuTitleScrollView];
        [self setUpControllerScrollView];
    }
    return self;
}
- (void)setUpMenuTitleScrollView{
    NSInteger index = 0;
    CGFloat itemWidth = self.view.bounds.size.width/_viewControllers.count;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kItemHeight * kHeightScale - 1 + kNaviHeigth, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = kPinkColor;
    [self.view addSubview:lineView];
    
    [self.view addSubview:self.menuScrollView];
    _bottomTipsView = [[UIView alloc]init];
    _bottomTipsView.backgroundColor = kPinkColor;
    _bottomTipsView.frame = CGRectMake(itemWidth * 0.1, 0, itemWidth * 0.8, 2);
    [self.menuScrollView addSubview:_bottomTipsView];
    
    
    __block typeof(self)weakSelf = self;
    for (UIViewController *VC in _viewControllers) {
        MenuTitleItem *item = [[MenuTitleItem alloc]initWithTitle:VC.title andPageIndex:index];
        item.frame = CGRectMake(index * itemWidth, kNaviHeigth, itemWidth, kItemHeight*kHeightScale);
        item.tag = index * 100;
        [self.view addSubview:item];
        
        [item setClickBlock:^(NSInteger index) {
            [weakSelf clickJumpToAnotherPage:index];
            if (weakSelf.isControllerScrolling == NO) {
                weakSelf.isControllerScrolling = YES;
                [weakSelf.controllerScrollView setContentOffset:CGPointMake((_currentIndex*self.view.bounds.size.width), 0) animated:YES];
               [weakSelf addControllerAtIndex:_currentIndex];
            }
        }];
        index++;
    }
    
    
}
- (void)setUpControllerScrollView{
    self.isControllerScrolling = NO;
    [self.view addSubview:self.controllerScrollView];
    UIViewController *vc = (UIViewController*)[_viewControllers objectAtIndex:0];
    [vc viewWillAppear:YES];
    [self addControllerAtIndex:0];
    [vc viewDidAppear:YES];
}
- (void)clickJumpToAnotherPage:(NSInteger)index{
    
    if (index == _currentIndex) {
        return ;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitleColor" object:@[@(_currentIndex),@(index)]];
        _currentIndex = index;
        [self.menuScrollView setContentOffset:CGPointMake(-(_currentIndex*self.view.bounds.size.width/_viewControllers.count), 0) animated:YES];
        
    }
}
- (void)addControllerAtIndex:(NSInteger)index{
    
    UIViewController *vc = (UIViewController*)_viewControllers[index];
    [vc willMoveToParentViewController:self];
    
    vc.view.frame = CGRectMake(index*self.view.bounds.size.width    ,0, self.view.bounds.size.width , self.view.bounds.size.height - kNaviHeigth - kItemHeight*kHeightScale);
    [self addChildViewController:vc];
    [self.controllerScrollView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

}
#pragma mark-ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.controllerScrollView && self.isControllerScrolling == NO) {
        CGPoint point = scrollView.contentOffset;
        NSInteger index = point.x / self.view.bounds.size.width;
        [self clickJumpToAnotherPage:index];
        if (index >= 0 && index < _viewControllers.count) {
            if (point.x == index * self.view.bounds.size.width) {
                 [self addControllerAtIndex:index];
            }
           
        }
    }
   
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
        self.isControllerScrolling = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
