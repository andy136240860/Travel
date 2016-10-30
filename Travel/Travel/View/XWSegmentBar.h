//
//  XWSegmentBar.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/26.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XWSegmentBarDelegate <NSObject>

- (void)didSelectedTitleWithIndex:(NSInteger)index;

@end

@interface XWSegmentBar : UIView

@property (nonatomic, retain) id <XWSegmentBarDelegate> delegate;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithTitls:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;

- (void)loadTitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;

+ (CGFloat)defaultHeight;

@end
