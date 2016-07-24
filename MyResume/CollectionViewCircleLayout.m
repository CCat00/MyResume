//
//  CollectionViewCircleLayout.m
//  MyResume
//
//  Created by 韩威 on 16/7/18.
//  Copyright © 2016年 韩威. All rights reserved.
//

#import "CollectionViewCircleLayout.h"

#pragma mark -

@implementation CircularCollectionViewLayoutAttributes

- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    
    self.zIndex = (NSInteger)(_angle * 1000000);
    
    self.transform = CGAffineTransformMakeRotation(_angle);
}

- (id)copyWithZone:(NSZone *)zone
{
    CircularCollectionViewLayoutAttributes *copiedAttributes = [super copyWithZone:zone];
    copiedAttributes.angle = _angle;
    copiedAttributes.anchorPoint = _anchorPoint;
    return copiedAttributes;
}

+ (instancetype)createCircleLayoutAttributesWith:(NSIndexPath *)indexPath
{
    CircularCollectionViewLayoutAttributes *attributes = [CircularCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.anchorPoint = CGPointMake(0.5, 0.5);
    return attributes;
}

@end



#pragma mark -

@interface CollectionViewCircleLayout ()

@property (nonatomic) NSInteger itemCountOfSectionZero;

@property (nonatomic, strong) NSMutableArray <CircularCollectionViewLayoutAttributes *> *attributesList;

@end

@implementation CollectionViewCircleLayout

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self comInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit
{
//    _itemSize = CGSizeMake(133, 173);
//    _radius = 500;
    
    
    
    _attributesList = [NSMutableArray array];
}


#pragma mark - Properties

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    
    [self invalidateLayout];
}

#pragma mark - Override

- (CGSize)collectionViewContentSize
{
    CGSize size = CGSizeMake((CGFloat)(self.itemCountOfSectionZero * self.itemSize.width), CGRectGetHeight(self.collectionView.bounds));
    return size;
}

+ (Class)layoutAttributesClass
{
    return [CircularCollectionViewLayoutAttributes class];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    //NSLog(@"CGRectGetWidth(self.collectionView.bounds) = %f", CGRectGetWidth(self.collectionView.bounds));
    
    CGFloat itemW = kScreenWidth / 5.0;
    
    // iPhone6 75 97.5 ==> 150 195
    self.itemSize = CGSizeMake(itemW, itemW * 1.3);
    self.radius = kScreenWidth / 2.0;

    
    
//    CGFloat itemW = CGRectGetWidth(self.collectionView.bounds) / 5.0;
//    
//    self.itemSize = CGSizeMake(itemW, itemW * 1.3);
//    self.radius = CGRectGetWidth(self.collectionView.bounds) / 2.0;
    
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGFloat anchorPointY = (self.itemSize.height / 2.0 + self.radius) / self.itemSize.height;
    
    // 1
    CGFloat theta = atan2(CGRectGetWidth(self.collectionView.bounds)/2, self.radius + (self.itemSize.height / 2.0) - (CGRectGetHeight(self.collectionView.bounds)/2.0));
    
    // 2
    NSInteger startIndex = 0;
    NSInteger endIndex = self.itemCountOfSectionZero - 1;
    
    // 3
    if (self.angle < -theta)
    {
        startIndex = (NSInteger)floor((-theta - self.angle) / self.anglePreItem);
    }
    
    // 4
    endIndex = MIN(endIndex, (NSInteger)ceil((theta - self.angle) / self.anglePreItem));
    
    // 5
    if (endIndex < startIndex)
    {
        endIndex = 0;
        startIndex = 0;
    }
    
    //[self.attributesList removeAllObjects];
    
    if (self.attributesList.count == 0)
    {
        for (NSInteger i = 0; i < self.itemCountOfSectionZero ; i++)
        {
            CircularCollectionViewLayoutAttributes *attributes = [CircularCollectionViewLayoutAttributes createCircleLayoutAttributesWith:[NSIndexPath indexPathForRow:i inSection:0]];
            attributes.size = self.itemSize;
            attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds));
            attributes.angle = self.angle + (self.anglePreItem * (CGFloat)i);
            attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
            [self.attributesList addObject:attributes];
        }
    }
    else
    {
        [_attributesList enumerateObjectsUsingBlock:^(CircularCollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
            attributes.size = self.itemSize;
            attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds));
            attributes.angle = self.angle + (self.anglePreItem * (CGFloat)idx);
            attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
        }];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributesList[indexPath.row];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


#pragma mark - Getter

- (CGFloat)anglePreItem
{
    return atan(_itemSize.width/_radius);
}


/**
 
 angle_for_last_item = angle_for_zero_item + (totalItems - 1) * anglePerItem
 0 = angle_for_zero_item + (totalItems - 1) * anglePerItem
 angle_for_zero_item = -(totalItems - 1) * anglePerItem
 
 */
- (CGFloat)angleAtExtreme
{
    return self.itemCountOfSectionZero > 0 ? -(self.itemCountOfSectionZero - 1) * self.anglePreItem : 0;
}

- (CGFloat)angle
{
//    NSLog(@"%f", (self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds))));
    return self.angleAtExtreme * self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds));
}


- (NSInteger)itemCountOfSectionZero
{
    return [self.collectionView numberOfItemsInSection:0];
}

@end
