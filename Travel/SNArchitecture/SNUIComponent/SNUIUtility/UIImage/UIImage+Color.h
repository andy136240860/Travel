//
//  UIImage+Color.h


#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

@end
