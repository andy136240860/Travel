//
//  TravelTogetherDetailVC.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/24.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWListController.h"
#import "Travel.h"
#import "TravelTogetherDetailListModel.h"

@interface TravelTogetherDetailVC : XWListController

@property (nonatomic, strong) TravelTogetherDetailListModel *listModel;
@property (nonatomic, strong) TravelTogetherPrivate *travelTogether;

@end
