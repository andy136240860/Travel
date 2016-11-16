//
//  CollectionHeaderViewForMeVC.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectionHeaderViewForMeVCHeight 708/2.f

typedef NS_ENUM(NSInteger, CollectionHeaderViewForMeVCClickModel) {
    CollectionHeaderViewModel_userAvatar    = 1,//用户头像
    CollectionHeaderViewModel_userName      = 2,//用户名称
    CollectionHeaderViewModel_myTravel      = 3,//我的旅程
    CollectionHeaderViewModel_myRequest     = 4,//我的请求
    CollectionHeaderViewModel_myService     = 5,//我的服务
    CollectionHeaderViewModel_myCollection  = 6,//我的收藏
    CollectionHeaderViewModel_myOrder       = 7,//我的订单
    
    CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage = 100,   //我的收藏首页背景图
    CollectionHeaderViewModel_setting       = 200,//设置
    CollectionHeaderViewModel_inbox         = 201,//私信提醒等等
};

@class CollectionHeaderViewForMeVC;

@protocol CollectionHeaderViewForMeVCDelegate <NSObject>

- (void)clickButtonActionWithModel:(CollectionHeaderViewForMeVCClickModel)model;

@end

@interface CollectionHeaderViewForMeVC : UICollectionReusableView

@property (nonatomic, weak) id <CollectionHeaderViewForMeVCDelegate> delegate;

- (void)resetData;

@end
