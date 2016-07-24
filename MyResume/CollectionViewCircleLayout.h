//
//  CollectionViewCircleLayout.h
//  MyResume
//
//  Created by 韩威 on 16/7/18.
//  Copyright © 2016年 韩威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic) CGFloat angle;
@property (nonatomic) CGPoint anchorPoint;

+ (instancetype)createCircleLayoutAttributesWith:(NSIndexPath *)indexPaht;

@end


@interface CollectionViewCircleLayout : UICollectionViewLayout

@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat radius;

@property (nonatomic) CGFloat anglePreItem;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat angleAtExtreme;


@end
