//
//  LjjUIsegumentViewController.m
//  HappyHall
//
//  Created by 李佳佳 on 15/6/30.
//  Copyright (c) 2015年 rencong. All rights reserved.
//

#import "LjjUISegmentedControl.h"
@interface LjjUISegmentedControl ()<LjjUISegmentedControlDelegate>
{
    CGFloat witdFloat;
    UIView* buttonDown;
    NSInteger selectSeugment;
}
@end

@implementation LjjUISegmentedControl
-(void)AddSegumentArray:(NSArray *)SegumentArray
{
    NSInteger seugemtNumber=SegumentArray.count;
    witdFloat=(self.bounds.size.width)/seugemtNumber;
    for (int i=0; i<SegumentArray.count; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2)];
        [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
//        NSLog(@"这里defont%@",[button.titleLabel.font familyName]);
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            buttonDown=[[UIView alloc]initWithFrame:CGRectMake(i*witdFloat, self.bounds.size.height-2, witdFloat, 2)];
            [buttonDown setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:buttonDown];
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    [[self.ButtonArray firstObject] setSelected:YES];
}
-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag];
    
}
-(void)selectTheSegument:(NSInteger)segument
{
    if (selectSeugment!=segument) {
        NSLog(@"我点击了");
        [self.ButtonArray[selectSeugment] setSelected:NO];
        [self.ButtonArray[segument] setSelected:YES];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [buttonDown setFrame:CGRectMake(segument*witdFloat,self.bounds.size.height-2, witdFloat, 2)];
        } completion:^(BOOL finished) {
            
        }];
        selectSeugment=segument;
        [self.delegate uisegumentSelectionChange:selectSeugment];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self.ButtonArray=[NSMutableArray array];
    selectSeugment=0;
    self.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, LjjUISegmentedControlDefaultHeight)];
//    self.LJBackGroundColor=[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f];
    self.titleColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2f];
    self.selectColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
//    [self setBackgroundColor:self.LJBackGroundColor];
    return self;
}

@end
