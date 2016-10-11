//
//  TravelDetailHeaderView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelDetailHeaderView : UIView

@property (nonatomic, strong) NSString    *backgroundImageURL;
@property (nonatomic, strong) NSString    *avatarImageURL;
@property (nonatomic, strong) NSString    *title;
@property (nonatomic, strong) NSString    *subTitle;
@property (nonatomic)         BOOL        isConcerned;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;

+ (CGFloat)defaultHeight;

@end
