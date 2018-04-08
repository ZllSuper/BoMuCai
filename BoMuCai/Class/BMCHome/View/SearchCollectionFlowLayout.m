//
//  SearchCollectionFlowLayout.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/1/18.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "SearchCollectionFlowLayout.h"

@implementation SearchCollectionFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.sectionInset = UIEdgeInsetsMake(2, 0, 10, 0);
    self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 25);
    self.minimumInteritemSpacing = 15;
}

- (void)layoutAttributesForItem:(UICollectionViewLayoutAttributes *)currentLayoutAttributes prevLayoutAttributes:(UICollectionViewLayoutAttributes *)prevLayoutAttributes
{
    if (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section)
    {
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 15;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if((origin + maximumSpacing + currentLayoutAttributes.frame.size.width) < (self.collectionViewContentSize.width - 15))
        {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    else
    {
        CGRect frame = currentLayoutAttributes.frame;
        frame.origin.x = 0;
        currentLayoutAttributes.frame = frame;
    }
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];

    UICollectionViewLayoutAttributes *prevLayoutAttributes = nil;
    for(int i = 0; i < [attributes count]; ++i)
    {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        if (currentLayoutAttributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            if (prevLayoutAttributes)
            {
                [self layoutAttributesForItem:currentLayoutAttributes prevLayoutAttributes:prevLayoutAttributes];
            }
            else
            {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = 0;
                currentLayoutAttributes.frame = frame;
            }
            prevLayoutAttributes = currentLayoutAttributes;
        }
    
    }
    return attributes;
}

- (CGSize)collectionViewContentSize
{
    CGSize superSize = [super collectionViewContentSize];
    if (superSize.height <= self.collectionView.height)
    {
        superSize.height = self.collectionView.height + 1;
    }
    return superSize;
}


@end
