//
//  XWTravelInteractionCellView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XWTravelInteractionCellViewCommendActionBlock)(void);
typedef void(^XWTravelInteractionCellViewCommentActionBlock)(void);
typedef void(^XWTravelInteractionCellViewShareActionBlock)(void);
typedef void(^XWTravelInteractionCellViewMoreActionBlock)(void);

@interface XWTravelInteractionCellView : UIView

@property (nonatomic, assign) BOOL hasCommend;
@property (nonatomic, assign) NSInteger commendNumber;

@property (nonatomic, assign) NSInteger commentNumber;

@property (nonatomic, copy) XWTravelInteractionCellViewCommendActionBlock commendActionBlock;
@property (nonatomic, copy) XWTravelInteractionCellViewCommentActionBlock commentActionBlock;
@property (nonatomic, copy) XWTravelInteractionCellViewShareActionBlock shareActionBlock;
@property (nonatomic, copy) XWTravelInteractionCellViewMoreActionBlock moreActionBlock;

@end
