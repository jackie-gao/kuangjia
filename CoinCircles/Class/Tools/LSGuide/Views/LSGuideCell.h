//
//  LSGuideCel.h
//
//  Created by larson on 2017/10/26.
//  Copyright © 2017年 larson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSGuideCell : UICollectionViewCell

/** 图片*/
@property(nonatomic,strong) UIImage *image;



/// 添加按钮
- (void)setUpIndexPath:(NSIndexPath *)indexPath count:(NSInteger)pagesCount;

@end
