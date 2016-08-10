//
//  ImageCollectionViewCell.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "ImageData.h"

@interface ImageCollectionViewCell()<UIGestureRecognizerDelegate>{
    tapBlock _block;
}
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)ImageData *data;
@property (nonatomic,strong)UITapGestureRecognizer *tap;
@end
@implementation ImageCollectionViewCell
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 2, self.bounds.size.width, self.bounds.size.height - 20*kHeightScale);
    }
    return _imageView;
}
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20*kHeightScale + 2, self.bounds.size.width, 20*kHeightScale - 2)];
        _titleLable.numberOfLines = 1;
        _titleLable.font = [UIFont systemFontOfSize:10*kHeightScale];
    }
    return _titleLable;
}
- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]init];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        _tap.delegate = self;
        [_tap addTarget:self action:@selector(clickCell)];
    }
    return _tap;
}
- (void)clickCell{
    if (_block) {
        _block(self.data);
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLable];
        [self addGestureRecognizer:self.tap];
    }
    return self;
}

- (void)setDataItem:(ImageData *)dataItem{
    if (dataItem) {
        self.data = dataItem;
        self.titleLable.text = dataItem.title;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataItem.thumb_url] placeholderImage:nil options:SDWebImageRetryFailed];
    }
}

- (void)setTapBlock:(tapBlock)block{
    if (block) {
        _block = block;
    }
}

@end
