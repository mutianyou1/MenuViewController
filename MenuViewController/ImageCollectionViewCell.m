//
//  ImageCollectionViewCell.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import "ImageCollectionViewCell.h"


@interface ImageCollectionViewCell(){

}
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLable;
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
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.backgroundColor = kPinkColor;
        self.titleLable.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLable];
    }
    return self;
}





@end
