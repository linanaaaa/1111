//
//  UIImage+Extension.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

//+ (UIImage *)image:(UIImage *)image withTintColor:(UIColor *)tintColor
//{
//    return [UIImage image:image withTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
//}
//
//+ (UIImage *)image:(UIImage *)image withGradientTintColor:(UIColor *)tintColor
//{
//    return [self image:image withTintColor:tintColor blendMode:kCGBlendModeOverlay];
//}
//
//+ (UIImage *)image:(UIImage *)image withTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
//{
//    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
//    [tintColor setFill];
//    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
//    UIRectFill(bounds);
//    
//    //Draw the tinted image in context
//    [image drawInRect:bounds blendMode:blendMode alpha:1.0f];
//    
//    if (blendMode != kCGBlendModeDestinationIn) {
//        [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
//    }
//    
//    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return tintedImage;
//}
//
//+ (UIImage *)resizedImage:(UIImage *)image
//{
//    return [image stretchableImageWithLeftCapWidth:image.size.width * .5 topCapHeight:image.size.height * .5];
//}
//
//+ (UIImage *)imageWithColor:(UIColor *)color
//{
//    return [self imageWithColor:color size:CGSizeMake(1.0, 1.0)];
//}
//
//+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    return [self imageWithBackgroundColor:color size:size];
//}
//
//+ (UIImage *)imageWithBackgroundColor:(UIColor *)backgroundColor size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    // 开启图像上下文
//    UIGraphicsBeginImageContext(rect.size);
//    // 获得当前上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // 使用颜色填充上下文
//    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
//    // 设置填充范围
//    CGContextFillRect(context, rect);
//    // 用当前的图形上下文生成图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    // 返回生成的图片
//    return image;
//}
//
//+ (UIImage *)imageWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor
//{
//    return [self imageWithBackgroundColor:backgroundColor borderColor:borderColor size:CGSizeMake(10.0, 10.0)];
//}
//
//+ (UIImage *)imageWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    // 开启图像上下文
//    UIGraphicsBeginImageContext(rect.size);
//    // 获得当前上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);//填充颜色
//    CGContextSetLineWidth(context, 2.0);//线的宽度
//    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
//    CGContextAddRect(context, rect); // 画矩形
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
//    
//    // 用当前的图形上下文生成图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    // 返回生成的图片
//    return image;
//}
//
//+ (UIImage *)imageWithText:(NSString *)text color:(UIColor *)color
//{
//    CGSize size = kTextSize(text, kFontSize(16.0), CGSizeMake(MAXFLOAT, MAXFLOAT));
//    
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    // 开启图像上下文
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
//    // 获得当前上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // 使用颜色填充上下文
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    // 设置填充范围
//    CGContextFillRect(context, rect);
//    
//    [text drawInRect:rect withAttributes:@{NSFontAttributeName : kFontSize(16.0), NSForegroundColorAttributeName : color}];
//    
//    // 用当前的图形上下文生成图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    // 返回生成的图片
//    return image;
//
//}
//
//+ (UIImage *)scaleImage:(UIImage *)image
//{
//    CGSize size;
//    CGFloat aspectRation = image.size.width / image.size.height;
//    if (image.size.width > image.size.height) {
//        size = CGSizeMake(1024, 1024 / aspectRation);
//    }
//    else {
//        size = CGSizeMake(1024 * aspectRation, 1024);
//    }
//    
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    transform = CGAffineTransformScale(transform, size.width / image.size.width , size.height / image.size.height);
//    CGContextConcatCTM(context, transform);
//    
//    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newimg;
//}
//
//+ (UIImage *)scaleImage:(UIImage *)image scale:(CGFloat)scale
//{
//    CGSize size = CGSizeMake(image.size.width * scale, image.size.height * scale);
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    transform = CGAffineTransformScale(transform, scale , scale);
//    CGContextConcatCTM(context, transform);
//    
//    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//    
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newimg;
//}

@end
