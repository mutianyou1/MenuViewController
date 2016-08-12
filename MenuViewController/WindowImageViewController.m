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
#import "WindowImageScrollView.h"
static const CGFloat kwidthMargin = 10.0;
static const CGFloat kheightMargin = 64.0;
static const CGFloat kThumblButtonHeight = 40;
static const NSInteger kemptyIndex = 29;
@interface WindowImageViewController ()<UIScrollViewDelegate>{
    
    NSMutableSet *_visiblePhoteSet;
    NSMutableSet *_reusealbePhotoSet;
    NSInteger _currentScrollingIndex;
    NSInteger _totoalPages;
}
@property (nonatomic,strong)UIScrollView *bigImageScrollView;
@property (nonatomic,strong)UIScrollView *thumblImageScrollView;
@property (nonatomic,strong)UILabel *numberTitleLabel;
@property (nonatomic,strong)UIButton *loveButton;
@property (nonatomic,strong)UIButton *showSelectedImagesButton;
@property (nonatomic,strong)NSMutableArray *selectedImageArray;
@property (nonatomic,strong)UILabel *contentLabel;
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
        _loveButton.userInteractionEnabled = YES;
        _loveButton.multipleTouchEnabled = NO;
    }
    return _loveButton;
}
- (UIButton *)showSelectedImagesButton{
    if (!_showSelectedImagesButton) {
        _showSelectedImagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showSelectedImagesButton.frame = CGRectMake(kWidth - kThumblButtonHeight - 10, 12, kThumblButtonHeight, kThumblButtonHeight);
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
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kwidthMargin, self.view.bounds.size.height - kheightMargin,self.view.bounds.size.width - kheightMargin, kheightMargin)];
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
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
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
        [self.selectedImageArray addObject:self.imageDataArray[_currentScrollingIndex]];
        [self addThumblImageONSelectedImagesButton];
    }else{
        [self.selectedImageArray removeObject:self.imageDataArray[_currentScrollingIndex]];
        [self removeThumblImageONSelectedImagesButton];
    }
}
- (void)showSelectedImages{
    
}
- (void)addThumblImageONSelectedImagesButton{
    
    UIImageView *thumbleImageView = (UIImageView*)[self.view viewWithTag:_currentScrollingIndex+kemptyIndex+_totoalPages];
    if (thumbleImageView) {
        return;
    }
    
    CGRect rect = self.showSelectedImagesButton.frame;
    rect.origin.x = 0;
    thumbleImageView = [[UIImageView alloc]initWithFrame:rect];
    thumbleImageView.tag = _currentScrollingIndex + kemptyIndex + _totoalPages;
    ImageData *data = self.imageDataArray[_currentScrollingIndex];
    [thumbleImageView sd_setImageWithURL:[NSURL URLWithString:data.thumb_url]];
    [self.view addSubview:thumbleImageView];
    [UIView animateWithDuration:1.5 animations:^{
        thumbleImageView.frame = self.showSelectedImagesButton.frame;
    } completion:^(BOOL finished) {
        
        [self.view bringSubviewToFront:self.showSelectedImagesButton];
        [thumbleImageView setTransform:CGAffineTransformMakeRotation(M_PI_4)];
    }];
    
}
- (void)removeThumblImageONSelectedImagesButton{
    UIImageView *thumbleImageView = (UIImageView*)[self.view viewWithTag:_currentScrollingIndex + kemptyIndex+_totoalPages];
    CGRect rect = self.showSelectedImagesButton.frame;
    rect.origin.x = -kThumblButtonHeight;
    [thumbleImageView setTransform:CGAffineTransformIdentity];
    
    [UIView animateWithDuration:1.5 animations:^{
        thumbleImageView.frame = rect;
    } completion:^(BOOL finished) {
        
        [thumbleImageView removeFromSuperview];
    }];
}
#pragma mark--- setMethod
- (void)setImageDataArray:(NSArray *)imageDataArray{
    [self.bigImageScrollView removeFromSuperview];
    _imageDataArray = [imageDataArray copy];
    _totoalPages = imageDataArray.count;
    self.bigImageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * imageDataArray.count, 0);
    [self.view addSubview:self.bigImageScrollView];
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentScrollingIndex = currentIndex;
    
    
    [self.view addSubview:self.numberTitleLabel];
    [self.view addSubview:self.showSelectedImagesButton];
    [self.view addSubview:self.loveButton];
    [self.view addSubview:self.contentLabel];
    
    [self addPinchScrollViewAtIndex:currentIndex];
    [self.bigImageScrollView setContentOffset:CGPointMake(kWidth * currentIndex, 0) animated:YES];
    self.numberTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex+1,self.imageDataArray.count];
    
}
#pragma mark--dismiss controller and window
- (void)tapForDismiss{
    [[WindowManager manager]setDismissBlock:^{
        //anything needed to be continued
    }];
}
#pragma mark--getScrollPhoto
- (void)showingPhotoWhenScrolling{
    
    
    CGRect rect = self.bigImageScrollView.bounds;
    int firstIndex = (int) floorf((CGRectGetMinX(rect)+2*kwidthMargin)/CGRectGetWidth(rect));
    int lastIndex = (int)floor((CGRectGetMaxX(rect)- 2 *kwidthMargin)/CGRectGetWidth(rect));
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    if (lastIndex >= _imageDataArray.count) {
        lastIndex --;
    }
    
    for (WindowImageScrollView *pinchScrollView in _visiblePhoteSet) {
        NSInteger index = [pinchScrollView tag] - kemptyIndex;
        if (index > lastIndex || index < firstIndex) {
            pinchScrollView.zoomScale = 1.0;
            [_reusealbePhotoSet addObject:pinchScrollView];
            [pinchScrollView removeFromSuperview];
        }
    }
    
    [_visiblePhoteSet minusSet:_reusealbePhotoSet];
    while (_reusealbePhotoSet.count > 2) {
        [_reusealbePhotoSet removeObject:[_reusealbePhotoSet anyObject]];
    }
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isPinchScrollViewOnView:index]) {
            [self addPinchScrollViewAtIndex:index];
        }
    }
    
    
}
- (void)addPinchScrollViewAtIndex:(NSInteger)index{
    CGRect  rect = CGRectMake(index * kWidth + kwidthMargin, kheightMargin, kWidth - kwidthMargin - kwidthMargin, kHeight - kheightMargin -kheightMargin);
    WindowImageScrollView *pinchScrollView  = [self dequeueReusablePinchScrollView];
    if (pinchScrollView) {
        pinchScrollView.frame = rect;
    }else{
        pinchScrollView = [[WindowImageScrollView alloc]initWithFrame:rect];;
    }
    pinchScrollView.zoomScale = 1.0;
    pinchScrollView.tag = kemptyIndex + index;
    ImageData *data = self.imageDataArray[index];
    pinchScrollView.imageData = data;
    if (index == 0) {
        self.contentLabel.text = data.title;
    }
    [self.bigImageScrollView addSubview:pinchScrollView];
    
    //_reuseableSet forbad to add anyObject
    [_visiblePhoteSet addObject:pinchScrollView];
}
- (BOOL)isPinchScrollViewOnView:(NSInteger)index{
    
    for (WindowImageScrollView *pinchScrollView in _visiblePhoteSet) {
        
        if (index == pinchScrollView.tag - kemptyIndex) {
            
            return YES;
        }
    }
    
    return NO;
}
- (WindowImageScrollView*)dequeueReusablePinchScrollView{
    WindowImageScrollView *pinchScrollView = [_reusealbePhotoSet anyObject];
    if (pinchScrollView) {
        [_reusealbePhotoSet removeObject:pinchScrollView];
    }
    return pinchScrollView;
}
#pragma mark--ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bigImageScrollView) {
        _currentScrollingIndex = scrollView.contentOffset.x / kWidth;
        self.numberTitleLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentScrollingIndex+1,self.imageDataArray.count];
        if (scrollView.contentOffset.x == _currentScrollingIndex * kWidth) {
            ImageData *data = self.imageDataArray[_currentScrollingIndex];
            self.contentLabel.text = data.title;
            UIImageView *thumbleImageView = (UIImageView*)[self.view viewWithTag:_currentScrollingIndex+kemptyIndex+_totoalPages];
            if (thumbleImageView) {
                self.loveButton.selected = YES;
                [self.view bringSubviewToFront:thumbleImageView];
                [self.view bringSubviewToFront:self.loveButton];
            }else{
                self.loveButton.selected = NO;
            }
        }
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
