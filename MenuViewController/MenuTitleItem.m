//
//  MenuTitleItem.m
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/5.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//https://github.com/naoyashiga/Dunk

#import "MenuTitleItem.h"

@interface MenuTitleItem()<UIGestureRecognizerDelegate>{
    UILabel *_titleLabel;
    NSInteger _pageIndex;
    block _block;
}

@end
@implementation MenuTitleItem
- (instancetype)initWithTitle:(NSString *)title andPageIndex:(NSInteger)pageIndex{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:kHeightScale * 18];
  
        [self addSubview:_titleLabel];
        _pageIndex = pageIndex;
        if (pageIndex == 0) {
            _titleLabel.textColor = [UIColor blackColor];
        }
        //gesture
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]init];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_tap addTarget:self action:@selector(clickMoveToPage)];
        [self addGestureRecognizer:_tap];
        
        //notification
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTitleColor:) name:@"changeTitleColor" object:nil];
    }
    return self;
}
- (void)didMoveToSuperview{
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 5);
    

}
- (void)clickMoveToPage{
   // [self.delegate clickMenuTitleItemToPage:_pageIndex];
    //_titleLabel.textColor = [UIColor blackColor];
    _block(_pageIndex);
}
- (void)setClickBlock:(block)block{
    if (block) {
        _block = block;
    }
}

- (void)changeTitleColor:(NSNotification*)notification{
    NSNumber *pageBefore = notification.object[0];
    NSNumber *pageAfter = notification.object[1];

    if (_pageIndex == pageBefore.integerValue) {
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    if (_pageIndex == pageAfter.integerValue) {
        _titleLabel.textColor = [UIColor blackColor];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
