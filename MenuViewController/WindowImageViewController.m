//
//  WindowImageViewController.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/10.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "WindowImageViewController.h"
#import "ImageData.h"
#import "WindowManager.h"
static const CGFloat kwidthMargin = 10.0;
static const CGFloat kheightMargin = 64.0;
static const CGFloat kThumblButtonHeight = 40;
static const NSInteger kemptyIndex = 29;
@interface WindowImageViewController ()<UIScrollViewDelegate>{
    UIActivityIndicatorView *_activityView;
    NSMutableSet *_visiblePhoteSet;
    NSMutableSet *_reusealbePhotoSet;
    NSInteger _currentScrollingIndex;
}
@property (nonatomic,strong)UIScrollView *bigImageScrollView;
@property (nonatomic,strong)UIScrollView *thumblImageScrollView;
@property (nonatomic,strong)UILabel *numberTitleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIButton *loveButton;
@property (nonatomic,strong)UIButton *showSelectedImagesButton;
@property (nonatomic,strong)NSMutableArray *selectedImageArray;
@end

@implementation WindowImageViewController
- (UIScrollView *)bigImageScrollView{
    if (!_bigImageScrollView) {
        _bigImageScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _bigImageScrollView.showsHorizontalScrollIndicator = NO;
        _bigImageScrollView.showsVerticalScrollIndicator = NO;
        _bigImageScrollView.pagingEnabled = YES;
        _bigImageScrollView.delegate = self;
    }
    
    return _bigImageScrollView;
}
- (UILabel *)numberTitleLabel{
    if (!_numberTitleLabel) {
        _numberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kWidth, 20*kHeightScale)];
        _numberTitleLabel.font = [UIFont systemFontOfSize:22*kHeightScale];
        _numberTitleLabel.textColor = [UIColor whiteColor];
        _numberTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberTitleLabel;
}
- (UIButton *)loveButton{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loveButton.frame = CGRectMake(kWidth - kheightMargin, kHeight - kheightMargin, kheightMargin, kheightMargin);
        [_loveButton setTitle:@"♡" forState:UIControlStateNormal];
        [_loveButton setTitle:@"♥︎" forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(ClikLoveToSelecteImage) forControlEvents:UIControlEventTouchUpInside];
        [_loveButton setTitleColor:kPinkColor forState:UIControlStateSelected];
    }
    return _loveButton;
}
- (UIButton *)showSelectedImagesButton{
    if (!_showSelectedImagesButton) {
        _showSelectedImagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showSelectedImagesButton.frame = CGRectMake(kWidth - kThumblButtonHeight - 10, 12, kThumblButtonHeight, kThumblButtonHeight);
        //_showSelectedImagesButton.backgroundColor = [UIColor whiteColor];
        [_showSelectedImagesButton addTarget:self action:@selector(showSelectedImages) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showSelectedImagesButton;
}
- (NSMutableArray *)selectedImageArray{
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray array];
    }
    return _selectedImageArray;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kwidthMargin, kHeight - kheightMargin, kWidth - kheightMargin, kheightMargin)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _visiblePhoteSet = [[NSMutableSet alloc]init];
    _reusealbePhotoSet = [[NSMutableSet alloc]init];
    
    _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(kWidth * 0.5 - 20, kHeight *0.5 -20, 40, 40);
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 2;
    [tap addTarget:self action:@selector(tapForDismiss)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-buttonMethod
- (void)ClikLoveToSelecteImage{
    self.loveButton.selected = !self.loveButton.selected;
    if (self.loveButton.selected) {
        [self.selectedImageArray addObject:self.imageDataArray[_currentIndex]];
        [self addThumblImageONSelectedImagesButton];
    }else{
        [self removeThumblImageONSelectedImagesButton];
    }
}
- (void)showSelectedImages{

}
- (void)addThumblImageONSelectedImagesButton{
    
    UIImageView *thumbleImageView = (UIImageView*)[self.view viewWithTag:_currentScrollingIndex+kemptyIndex];
    if (thumbleImageView) {
        return;
    }
    
    CGRect rect = self.showSelectedImagesButton.frame;
    rect.origin.x = 0;
    thumbleImageView = [[UIImageView alloc]initWithFrame:rect];
    thumbleImageView.tag = _currentScrollingIndex + kemptyIndex;
    ImageData *data = self.imageDataArray[_currentScrollingIndex];
    [thumbleImageView sd_setImageWithURL:[NSURL URLWithString:data.thumb_url]];
     [self.view addSubview:thumbleImageView];
    [UIView animateWithDuration:0.4 animations:^{
        thumbleImageView.frame = self.showSelectedImagesButton.frame;
    } completion:^(BOOL finished) {
       
        [self.view bringSubviewToFront:self.showSelectedImagesButton];
        [thumbleImageView setTransform:CGAffineTransformMakeRotation(M_PI_4)];
    }];
    
}
- (void)removeThumblImageONSelectedImagesButton{
    UIImageView *thumbleImageView = (UIImageView*)[self.view viewWithTag:_currentScrollingIndex + kemptyIndex];
    CGRect rect = self.showSelectedImagesButton.frame;
    rect.origin.x = -kThumblButtonHeight;
    [thumbleImageView setTransform:CGAffineTransformIdentity];
    
    [UIView animateWithDuration:0.4 animations:^{
        thumbleImageView.frame = rect;
    } completion:^(BOOL finished) {
        
        [thumbleImageView removeFromSuperview];
    }];
}
#pragma mark--- setMethod
- (void)setImageDataArray:(NSArray *)imageDataArray{
    [self.bigImageScrollView removeFromSuperview];
    _imageDataArray = [imageDataArray copy];
    self.bigImageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * imageDataArray.count, 0);
    [self.view addSubview:self.bigImageScrollView];
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
     _currentScrollingIndex = currentIndex;
    
    
    [self.view addSubview:_activityView];
    
    [self.view addSubview:self.numberTitleLabel];
    [self.view addSubview:self.showSelectedImagesButton];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.loveButton];
    _activityView.hidden = NO;
    [_activityView startAnimating];
   
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(currentIndex * self.view.bounds.size.width + kwidthMargin, kheightMargin, self.view.bounds.size.width - kwidthMargin - kwidthMargin, self.view.bounds.size.height - kheightMargin-kheightMargin)];
   
    ImageData *data = (ImageData*)self.imageDataArray[currentIndex];
    [imageView sd_setImageWithURL:[NSURL URLWithString:data.image_url] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_activityView stopAnimating];
    }];
    [self.bigImageScrollView addSubview:imageView];
    [self.bigImageScrollView setContentOffset:CGPointMake(kWidth * currentIndex, 0) animated:YES];
    self.numberTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex+1,self.imageDataArray.count];
    self.contentLabel.text = data.title;
    
    
    [_reusealbePhotoSet addObject:imageView];
    [_visiblePhoteSet addObject:imageView];
}
#pragma mark--getScrollPhoto
- (void)tapForDismiss{
    [[WindowManager manager]setDismissBlock:^{
        
    }];
}
- (void)showingPhotoWhenScrolling{
    if (_visiblePhoteSet.count < 2) {
        return;
    }
    
    
    
}
- (void)addPhotoAtIndex:(NSInteger)index{
   
}
#pragma mark--ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bigImageScrollView) {
        _currentScrollingIndex = scrollView.contentOffset.x / kWidth;
        
        [self showingPhotoWhenScrolling];
    }
}
- (BOOL)prefersStatusBarHidden{
    return YES;
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
