//
//  MeiZiCollectionViewController.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "MeiZiCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "ImageData.h"
#import "WindowManager.h"
#import "FileManager.h"
#import <MJRefresh/MJRefresh.h>
#import <MJRefresh/MJRefreshFooter.h>
#import <objc/runtime.h>
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
- (void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.frame = CGRectMake(5, 0, self.view.bounds.size.width - 10.0, self.view.bounds.size.height);
    self.collectionView.backgroundColor = kBackgroundColor;
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:self.title]) {
       NSNumber *page  = (NSNumber*)[[NSUserDefaults standardUserDefaults]objectForKey:self.title];
        self.page = page.integerValue - 1;
    }else{
        self.page = 1;
    }
    _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 20, self.view.bounds.size.height * 0.5 - 20 - 64 - 40*kHeightScale, 40, 40);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    [self requestForImageWithProgress:nil];
    
    
  __block  __weak typeof(self) weakSelf = self;
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestForImageWithProgress:nil];
    }];
    footer.automaticallyHidden = YES;
    footer.automaticallyChangeAlpha = YES;
    [self.collectionView setMj_footer:footer];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)requestForImageWithProgress:(void(^)(NSProgress *progress))progressBlock{
    
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    [[ConnectionManager manager]requestWithMeiZiCategory:self.category page:pageString progress:^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } success:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if([[FileManager manager]saveJasonToDisk:responseObject[@"results"] pathKey:self.title]){
                    [[NSUserDefaults standardUserDefaults]setObject:@(self.page) forKey:self.title];
                    NSLog(@"write success");
                }else{
                    NSLog(@"write failed");
                }
        });
       
      
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageArray addObjectsFromArray:[ImageData getImageDataItemWithDictionary:responseObject[@"results"]]];
             objc_setAssociatedObject([WindowManager manager],(__bridge const void *)(self.title), self.imageArray,OBJC_ASSOCIATION_COPY);
            self.page ++;
            [self.collectionView.mj_footer endRefreshing];
            [_activityView stopAnimating];
            [self.collectionView reloadData];
        });
    } failure:^(NSError *error) {
        [self reloadDataWithCache];
    }];

}
- (void)reloadDataWithCache{
   NSNumber *page  = (NSNumber*)[[NSUserDefaults standardUserDefaults]objectForKey:self.title];
    
    [self.collectionView.mj_footer endRefreshing];
    if (self.page > page.integerValue ) {
        return;
    }
    
    
    self.page = page.integerValue+1;
    [_activityView stopAnimating];
    
    NSDictionary *dict = (NSDictionary*)[[FileManager manager]getJasonFromFileWithTitle:self.title];
    if (dict) {
       [self.imageArray addObjectsFromArray:[ImageData getImageDataItemWithDictionary:dict]];
        
        objc_setAssociatedObject([WindowManager manager],(__bridge const void *)(self.title), self.imageArray,OBJC_ASSOCIATION_COPY);
    }
    
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ImageCollectionViewCell alloc]init];
    }
    [cell setDataItem:self.imageArray[indexPath.row]];
    [cell setTapBlock:^(ImageData *data) {
        [[WindowManager manager]showWindowWithMeiZiCategory:self.title withSelectedImageIndex:indexPath.row];
    }];
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
