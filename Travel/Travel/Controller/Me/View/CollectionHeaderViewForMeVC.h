//
//  CollectionHeaderViewForMeVC.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectionHeaderViewForMeVCHeight 370

typedef NS_ENUM(NSInteger, CollectionHeaderViewForMeVCClickModel) {
    CollectionHeaderViewModel_userAvatar    = 1,//用户头像
    CollectionHeaderViewModel_userName      = 2,//用户名称
    CollectionHeaderViewModel_myTravel      = 3,//我的旅程
    CollectionHeaderViewModel_myRequest     = 4,//我的请求
    CollectionHeaderViewModel_myService     = 5,//我的服务
    CollectionHeaderViewModel_myCollection  = 6,//我的收藏
    CollectionHeaderViewModel_myOrder       = 7,//我的订单
};

@class CollectionHeaderViewForMeVC;

@protocol CollectionHeaderViewForMeVCDelegate <NSObject>

- (void)clickButtonActionWithModel:(CollectionHeaderViewForMeVCClickModel)model;

@end

@interface CollectionHeaderViewForMeVC : UICollectionReusableView

@property (nonatomic, retain) id <CollectionHeaderViewForMeVCDelegate> delegate;

- (void)resetData;

@end
