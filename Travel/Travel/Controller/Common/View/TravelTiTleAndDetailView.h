//
//  TravelTiTleAndDetailView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTiTleAndDetailView : UIView

@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *price;

- (instancetype)init;

@end
