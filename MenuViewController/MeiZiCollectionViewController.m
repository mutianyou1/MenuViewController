//
//  MeiZiCollectionViewController.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "MeiZiCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "ConnectionManager.h"

@interface MeiZiCollectionViewController (){
    UIActivityIndicatorView *_activityView;
}
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MeiZiCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.frame = CGRectMake(5, 0, self.view.bounds.size.width - 10.0, self.view.bounds.size.height);
    self.collectionView.backgroundColor = kBackgroundColor;
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 20, self.view.bounds.size.height * 0.5 - 20, 40, 40);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    
    //[self requestForImage];
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)requestForImage{
    [[ConnectionManager manager]requestWithMeiZiCategory:MeiZiCategoryZaHui page:@"2" success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];

}
- (void)reloadData{
    [self.collectionView reloadData];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ImageCollectionViewCell alloc]init];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
