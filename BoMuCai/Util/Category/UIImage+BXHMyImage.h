//
//  UIImage+BXHMyImage.h
//  MessageList
//
//  Created by 步晓虎 on 14-9-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BXHMyImage)

/**
 *修正图片转向问题
 */
- (UIImage *)fixOrientation;

- (UIImage *)resizedImageWithSize:(CGSize)size;

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

- (CGRect)convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

- (UIImage *)nineCutImage:(UIEdgeInsets)edge;

/**
 *imageEffect
 */
- (UIImage *)applyLightEffect;

- (UIImage *)applyExtraLightEffect;

- (UIImage *)applyDarkEffect;

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)scaledToSize:(CGSize) newSize;

- (NSString *)scaleToByteSize:(unsigned long)size andImageWidth:(CGFloat)width;

- (NSString *)base64Encode;

- (UIImage *)drawRectWithRoundedCorner:(CGFloat)cornerRadius size:(CGSize)size;

UIImage * ImageWithColor(UIColor * color);


@end
