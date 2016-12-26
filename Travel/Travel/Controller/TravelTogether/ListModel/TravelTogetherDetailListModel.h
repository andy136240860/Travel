//
//  TravelTogetherDetailListModel.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/28.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWBaseListModel.h"
#import "Travel.h"

@interface TravelTogetherDetailListModel : XWBaseListModel

@property (nonatomic, strong) TravelTogether *travelTogether;

@property (nonatomic, strong) NSMutableArray *displayInfos;

@end
