//
//  TravelMatesView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelMatesView : UIView

@property (nonatomic, assign) NSInteger totalNumber;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
+ (CGFloat)defaultHeight;

@end
