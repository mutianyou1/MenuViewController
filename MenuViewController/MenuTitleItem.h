//
//  MenuTitleItem.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/5.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSInteger index);
@interface MenuTitleItem : UIView
- (instancetype)initWithTitle:(NSString*)title andPageIndex:(NSInteger)pageIndex;
- (void)setClickBlock:(block)block;
@end
