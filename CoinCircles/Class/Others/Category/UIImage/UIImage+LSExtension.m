//
//  UIImage+LSImage.m
//
//  Created by Larson on 2016/9/21.
//  Copyright © 2016年 Larson. All rights reserved.
//

#import "UIImage+LSExtension.h"

@implementation UIImage (LSExtension)

#pragma mark - <将图片变为一张圆形图片>
- (UIImage *)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


#pragma mark - <调整图片的大小>
- (UIImage *)resizeImage:(UIImage *)originalImage resizeToSize:(CGSize)newSize
{
    // 当前屏幕的像素比
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



#pragma mark - 返回一张从中心点拉伸的图片
- (instancetype)imageWithStretchableImage:(UIImage *)image imageSize:(CGSize)imageSize
{
    return [image stretchableImageWithLeftCapWidth:imageSize.width / 2 topCapHeight:imageSize.height / 2];
}



#pragma mark - <根据指定的宽度等比压缩图片>
- (UIImage *)imageScaleWithWidth:(CGFloat)width
{
    // 传入的宽度不能超过当前屏幕的宽度
    if (width > [UIScreen mainScreen].bounds.size.width) {
        return self;
    }
    
    // 根据宽度计算高度
    CGFloat height = (width / self.size.width) * self.size.height;
    
    // 按照宽高比绘制一张新的图片
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - <根据屏幕宽度压缩图片>
- (UIImage *)imageScaleWithScreenWidth
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * self.size.height / self.size.width;
    
    UIImage *scaleImage = nil;
    // 高度小于宽度，从中间剪切图片
    if (self.size.height < self.size.width) {
        CGFloat x = (self.size.width - self.size.height) / 2;
        CGImageRef cgRef = self.CGImage;
        CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(x, 0, self.size.height, self.size.height));
        scaleImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        height = width;
    }

    // 按照宽高比绘制一张新的图片
    CGRect rect = CGRectMake(0, 0, height, width);
    UIGraphicsBeginImageContext(rect.size);
    if (scaleImage) {
        [scaleImage drawInRect:rect];
    } else {
        [self drawInRect:rect];
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}





#pragma mark - <生成一张渐变色图片>
/**
 *  获取矩形的渐变色的UIImage(此函数还不够完善)
 *
 *  @param bounds       UIImage的bounds
 *  @param colors       渐变色数组，可以设置两种颜色
 *  @param gradientType 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}



#pragma mark - <带圆角的图片>
+ (UIImage *)roundedCornerImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius{
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 绘制带圆角的图片
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:10];
    [path addClip];
    
    [image drawAtPoint:CGPointZero];
    
    UIImage *clipImag = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return clipImag;
}



#pragma mark - 返回一张不经过渲染的图片
+(instancetype)imageWithOriginalRenderingImageNamed:(NSString *)imageNamed
{
    UIImage *image = [UIImage imageNamed:imageNamed];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



#pragma mark - <根据CIImage生成指定大小的UIImage>
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark - <合成一张带边框的二维码图片>
+ (UIImage *)synthesisWithBorderQRCodeImage:(UIImage *)borderImage QRCodeImage:(UIImage *)codeImage
{
    // @2x和@3x的拉伸方式是不一样的
    UIGraphicsBeginImageContextWithOptions(borderImage.size, NO, [UIScreen mainScreen].scale);
    
    [borderImage drawInRect:CGRectMake(0, 0, borderImage.size.width, borderImage.size.height)];
    [codeImage drawInRect:CGRectMake( 10, 10, borderImage.size.width - 20, borderImage.size.height - 20)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}



#pragma mark - <合成一张带头像的二维码图片>
+ (UIImage *)synthesisWithIconQRCodeImage:(UIImage *)QRCodeImage iconImage:(UIImage *)iconImage
{
    UIGraphicsBeginImageContext(QRCodeImage.size);

    [QRCodeImage drawInRect:CGRectMake(0, 0, QRCodeImage.size.width, QRCodeImage.size.height)];
    [iconImage drawInRect:CGRectMake((QRCodeImage.size.width - iconImage.size.width) / 2, (QRCodeImage.size.height - iconImage.size.height) / 2, iconImage.size.width, iconImage.size.height)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}



#pragma mark - <根据颜色生成一张图片>
+ (UIImage *)getImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



#pragma mark - <根据图片的宽度获取一张等比缩放的图片>
+ (UIImage *)getScaleScalingImageWithOriginalImage:(UIImage *)originalImage imageWidth:(CGFloat)imageWidth
{
    // 当前屏幕的像素比
    CGFloat scale = [[UIScreen mainScreen]scale];
    CGFloat imageHeight = imageWidth * originalImage.size.height / originalImage.size.width;
    CGSize newSize = CGSizeMake(imageWidth, imageHeight);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    return nil;
}



//// 在图片上添加文字
//- (UIImage *)addText:(NSString *)text textFontSize:(NSInteger)fontSize color:(UIColor *)color
//{
//    //上下文的大小
//        int w = self.size.width;
//        int h = self.size.height;
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
//        //创建上下文
//        CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//        CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);//将img绘至context上下文中
//        CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
//        char* textChar = (char *)[text cStringUsingEncoding:NSASCIIStringEncoding];
//        CGContextSelectFont(context, "Georgia", 50, kCGEncodingMacRoman);//设置字体的大小
//        CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
//        CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
//        CGContextShowTextAtPoint(context, w/2-strlen(textChar)*5, h/2, textChar, strlen(textChar));//设置字体绘制的位置
//        //Create image ref from the context
//        CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
//        CGContextRelease(context);
//        CGColorSpaceRelease(colorSpace);
//    
//        return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
//}


// 指定宽度按比例缩放
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
   UIImage *newImage = nil;
   CGSize imageSize = sourceImage.size;
   CGFloat width = imageSize.width;
   CGFloat height = imageSize.height;
   CGFloat targetWidth = defineWidth;
   CGFloat targetHeight = height / (width / targetWidth);
   CGSize size = CGSizeMake(targetWidth, targetHeight);
   CGFloat scaleFactor = 0.0;
   CGFloat scaledWidth = targetWidth;
   CGFloat scaledHeight = targetHeight;
   CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
   if(CGSizeEqualToSize(imageSize, size) ==NO){
       CGFloat widthFactor = targetWidth / width;
       CGFloat heightFactor = targetHeight / height;

       if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
       if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
   if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
   return newImage;
}



#pragma mark - <将图片保存到本地>
+ (void)SaveImageToLocal:(UIImage*)image imageName:(NSString*)imageName
{
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),imageName];

    if ([self LocalHaveImage:imageName]) [self RemoveImageToLocalImageName:imageName];

    NSData *imgData = UIImageJPEGRepresentation(image,0.5);

    [imgData writeToFile:picPath atomically:YES];
}

/// 本地是否有图片
+ (BOOL)LocalHaveImage:(NSString*)imageName {
//    if ([self isBlankString:key]) {
//        return NO;
//    }

    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),imageName];

    UIImage *img=[[UIImage alloc]initWithContentsOfFile:picPath];

    if (img) return YES;
    
    return NO;
}


// 从本地获取图片
+ (UIImage*)GetLocationImageFromImageName:(NSString*)imageName
{
//    if ([JKBlankTool isBlankString:key]) {
//
//        return nil;
//
//    }
    
    if (![self LocalHaveImage:imageName]) {
        return nil;
    }

    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),imageName];
    UIImage *img=[[UIImage alloc]initWithContentsOfFile:picPath];

    return img;
}

// 将图片从本地删除
+ (void)RemoveImageToLocalImageName:(NSString*)imageName
{
    if ([self LocalHaveImage:imageName]) {
        return;
    }
    
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),imageName];
    [[NSFileManager defaultManager] removeItemAtPath:picPath error:nil];
}

@end





