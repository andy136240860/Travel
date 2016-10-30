//
//  EditTravelTogetherTableViewCell.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/14.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Travel.h"

@interface EditTravelTogetherTableViewBaseCell : UITableViewCell

@property (nonatomic, strong) TravelTogether *travelTogether;
@property (nonatomic, strong) UIView *contentPickerView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (UIView *)loadContentView; //添加视图到contentPickerView上面
- (void)pickViewWillAppear; //点击之后视图将要显示的时候的事件
- (void)confirmAction; //点击确定的事件
- (void)closeView; //关闭选择框

@end

@interface EditTravelTogetherTableViewCell_0_0 : UITableViewCell  //旅行目的地

@property (nonatomic, strong) TravelTogether *travelTogether;

@end

@interface EditTravelTogetherTableViewCell_0_1 : EditTravelTogetherTableViewBaseCell  //开始时间

@property (nonatomic, strong)    NSDate *dateSelected;

@end

@interface EditTravelTogetherTableViewCell_0_2 : EditTravelTogetherTableViewCell_0_1  //结束时间

@end

@interface EditTravelTogetherTableViewCell_0_3 : EditTravelTogetherTableViewBaseCell  //旅行人数

@end

@interface EditTravelTogetherTableViewCell_0_4 : EditTravelTogetherTableViewBaseCell  //交通状况

@end

@interface EditTravelTogetherTableViewCell_0_5 : UITableViewCell  //语音支持

@property (nonatomic, strong) TravelTogether *travelTogether;

@end

@interface EditTravelTogetherTableViewCell_0_6 : EditTravelTogetherTableViewBaseCell  //同行人员

@end

@interface EditTravelTogetherTableViewCell_0_7 : EditTravelTogetherTableViewBaseCell  //旅行花费预算

@end

@interface EditTravelTogetherTableViewCell_0_8 : EditTravelTogetherTableViewBaseCell  //导游

@end
