//
//  XWImageShowView.h
//  Travel
//
//  Created by 晓炜 郭 on 16/7/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWImageShowView : UIView

@property (strong, nonatomic) NSArray *imageURLArray;
- (instancetype)init;

+ (CGFloat)XWImageShowViewHeightWithImageNumber:(NSInteger)num;
+ (CGFloat)XWImageShowViewWidth;

@end
