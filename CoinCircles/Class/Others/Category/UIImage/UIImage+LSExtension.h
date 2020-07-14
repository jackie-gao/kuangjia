//
//  UIImage+LSImage.h
//
//  Created by Larson on 2016/9/21.
//  Copyright © 2016年 Larson. All rights reserved.
//

// ----- 图片设置的分类 ----- //

#import <UIKit/UIKit.h>

@interface UIImage (LSExtension)

/** 将图片变为一张圆形图片*/
- (UIImage *)circleImage;

/** 返回一张从中心点拉伸的图片*/
- (instancetype)imageWithStretchableImage:(UIImage *)image imageSize:(CGSize)imageSize;

/** 调整图片的大小*/
- (UIImage *)resizeImage:(UIImage *)originalImage resizeToSize:(CGSize)size;

/** 根据指定的宽度等比压缩图片*/
- (UIImage *)imageScaleWithWidth:(CGFloat)width;
/** 根据屏幕宽度压缩图片*/
- (UIImage *)imageScaleWithScreenWidth;



/** 生成一张渐变色图片*/
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType;

/** 将图片变为一张带圆角的图片*/
+ (UIImage *)roundedCornerImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius;

/** 返回一张原始图片*/
+ (UIImage *)imageWithOriginalRenderingImageNamed:(NSString *)imageNamed;

/** 生成一张高清的二维码图片*/
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/** 合成一张带边框的二维码图片*/
+ (UIImage *)synthesisWithBorderQRCodeImage:(UIImage *)borderImage QRCodeImage:(UIImage *)codeImage;

/** 合成一张带头像的二维码图片*/
+ (UIImage *)synthesisWithIconQRCodeImage:(UIImage *)QRCodeImage iconImage:(UIImage *)iconImage;



/**
 *  根据颜色生成一张图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage *)getImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

/**
 *  根据图片的宽度获取一张等比缩放的图片
 *
 *  @param originalImage    原始的图片
 *  @param imageWidth       图片的宽度
 */
+ (UIImage *)getScaleScalingImageWithOriginalImage:(UIImage *)originalImage
                                        imageWidth:(CGFloat)imageWidth;


/**
 *  在图片上添加文字
 *
 */
//- (UIImage *)addText:(NSString *)text textFontSize:(NSInteger)fontSize color:(UIColor *)color;

/**
 * 指定宽度按比例缩放
 *
 * @param sourceImage                   原始的图片
 * @param defineWidth                   指定的宽度
 *
 * @return                    等比缩放之后的图片
 */
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 * 保存图片到本地
 *
 * @param image                                需要保存的图片
 * @param imageName                       图片名
 */
+ (void)SaveImageToLocal:(UIImage*)image imageName:(NSString*)imageName;

/**
 * 从本地获取图片
 *
 * @param imageName                       图片名
 */
+ (UIImage*)GetLocationImageFromImageName:(NSString*)imageName;

/**
 * 是否有本地图片
 *
 * @param imageName                       图片名
 */
+ (BOOL)LocalHaveImage:(NSString*)imageName;

@end
