//
//  LSCollectionReusableView.m
//  shanShuiHotel
//
//  Created by larson on 2018/12/24.
//  Copyright © 2018年 qingYunHotelInfo. All rights reserved.
//

#import "LSCollectionReusableView.h"
#import "LSCollectionViewLayoutAttributes.h"

@implementation LSCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    if ([layoutAttributes isKindOfClass:[LSCollectionViewLayoutAttributes class]]) {
        LSCollectionViewLayoutAttributes *attr = (LSCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

@end
