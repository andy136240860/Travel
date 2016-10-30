//
//  EditTravelTogetherHeaderView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditTravelTogetherHeaderView;

@protocol EditTravelTogetherHeaderViewDelegate <NSObject>

- (void)ChangeBackgroundImageWithEditTravelTogetherHeaderView:(EditTravelTogetherHeaderView *)view;

@end

@interface EditTravelTogetherHeaderView : UIView

@property (nonatomic, strong) UIImageView   *backgroundImageView;
@property (nonatomic, strong) UITextField   *titleTextField;

@property (nonatomic, retain) id <EditTravelTogetherHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;
+ (CGFloat)defaultHeight;

@end
