//
//  ImageCollectionViewCell.h
//  MenuViewController
//
//  Created by 潘元荣(外包) on 16/8/8.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageData;
typedef void(^tapBlock)(ImageData *data);
@interface ImageCollectionViewCell : UICollectionViewCell
- (void)setTapBlock:(tapBlock)block;
- (void)setDataItem:(ImageData*)dataItem;
@end
