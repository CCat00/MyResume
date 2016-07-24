//
//  CollectionViewCell.m
//  MyResume
//
//  Created by 韩威 on 16/7/18.
//  Copyright © 2016年 韩威. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionViewCircleLayout.h"

@implementation CollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentView.layer.borderWidth = .5;
        self.contentView.layer.shouldRasterize = YES;
        self.contentView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


//- (void)setHighlighted:(BOOL)highlighted
//{
//    [super setHighlighted:highlighted];
//    
//    if (highlighted) {
//        self.imgView.hidden = YES;
//        self.backgroundColor = [UIColor redColor];
//    }
//    else
//    {
//        self.imgView.hidden = NO;
////        self.backgroundColor = [UIColor whiteColor];
//    }
//}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    CircularCollectionViewLayoutAttributes *circularLayoutAttributes = (CircularCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.layer.anchorPoint = circularLayoutAttributes.anchorPoint;
    CGPoint center = self.center;
    center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds);
    self.center = center;
}

@end
