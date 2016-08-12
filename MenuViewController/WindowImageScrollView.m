//
//  WindowImageScrollView.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/10.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "WindowImageScrollView.h"

@interface WindowImageScrollView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    
}
@property (nonatomic,strong)UIImageView *zoomImageView;
@property (nonatomic,strong)UIActivityIndicatorView *activityView;
@end
@implementation WindowImageScrollView
- (UIImageView *)zoomImageView{
    if (!_zoomImageView) {
        _zoomImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _zoomImageView;
}
- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.frame = CGRectMake(self.bounds.size.width * 0.5 - 40, self.bounds.size.height*0.5 - 40, 80, 80);
    }
    return _activityView;
}

#pragma mark--setMethod
- (void)setImageData:(ImageData *)imageData{
    if (imageData) {
        _imageData = imageData;
        [self.activityView startAnimating];
        [self.zoomImageView sd_setImageWithURL:[NSURL URLWithString:imageData.image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.activityView stopAnimating];
        }];
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.zoomImageView];
        [self addSubview:self.activityView];
        [self.activityView startAnimating];
        self.delegate = self;
        self.maximumZoomScale = 2.5;
        self.minimumZoomScale = 0.5;
    }
    
    return self;
}


#pragma mark--ScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width)*0.5:0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0;
    self.zoomImageView.center = CGPointMake(offsetX+scrollView.contentSize.width * 0.5, offsetY + scrollView.contentSize.height * 0.5);
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.zoomImageView;
}
#pragma mark--gestureDelegate

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
