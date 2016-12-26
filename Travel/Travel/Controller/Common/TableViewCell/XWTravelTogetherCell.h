//
//  XWTravelTogetherCell.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelBaseCell.h"
#import "XWTravelTogetherDetailCellView.h"

@interface XWTravelTogetherCell : XWTravelBaseCell

@property (nonatomic, strong) XWTravelTogetherDetailCellView *detailView;
@property (nonatomic, strong) TravelTogether *travelTogether;

@end
