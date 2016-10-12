//
//  CUUIContant.h
//  CollegeUnion
//
//  Created by li na on 15/3/5.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#ifndef CollegeUnion_CUUIContant_h
#define CollegeUnion_CUUIContant_h

#import "UIColor+SNExtension.h"

// 均已6的分辨率为基准
#define Height_AdaptedFactor ([UIScreen mainScreen].bounds.size.height/(1334.0/2))
#define Width_AdaptedFactor ([UIScreen mainScreen].bounds.size.width/(750.0/2))

//--------------------rect---------------------

#define ScreenWidth             ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight            ([UIScreen mainScreen].bounds.size.height)
#define Height_NavigationBar    (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0) ? 64.0 : 44.0)
#define Height_StatusBar        (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(IOS_7_0) ? 20.0 : 0.0)
#define Height_Tabbar           50


/**--------------navigation----------------------**/
extern NSInteger Color_Hex_NavItem_Normal;
extern NSInteger Color_Hex_NavText_Normal;
extern NSInteger Color_Hex_NavText_Selected;
extern NSInteger Color_Hex_NavBackground;
extern NSString * ImgStr_BackBtn;
extern NSString * imgStr_CloseBtn;
extern NSString * ImgStr_NavBackground;
extern NSInteger Color_Hex_NavShadow;


/**--------------view background----------------------**/
extern NSInteger Color_Hex_ContentViewBackground;

/**--------------content text/image color----------------------**/
extern NSInteger Color_Hex_Text_Normal;
extern NSInteger Color_Hex_Text_Selected;
extern NSInteger Color_Hex_Text_Readed;
extern NSInteger Color_Hex_Text_Highlighted;
extern NSInteger Color_Hex_ImageDefault;

/**--------------tableview ----------------------**/
extern NSInteger Color_Hex_Tableview_Separator;

/**-------------------tabbar----------------------**/
extern CGFloat FontSize_TabbarItemTitle; // kSNTabBarItemTitleFontSize 12
extern CGFloat vPadding_Top_TabbarItemBadgeView; //kSNTabBarItemBadgeViewTPadding 3
extern CGFloat hPadding_Right_TabbarItemBadgeView; //kSNTabBarItemBadgeViewRPadding 10
extern CGFloat vPadding_Bottom_TabbarItemTitle;
extern CGFloat vSpace_TabbarItemImg_Title; // kSNTabBarItemImgTitleInterval 0.5
extern CGFloat vPadding_Top_TabbarItemImg;

/**
 *  image default
 */
extern NSString * ImgStr_Default;



#endif


