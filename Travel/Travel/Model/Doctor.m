//
//  Doctor.m
//  FindDoctor
//
//  Created by zhouzhenhua on 15/8/13.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

//- (NSString *)availableDesc
//{
//    if (self.isAvailable) {
//        return @"可预约";
//    }
//    
//    return @"预约满";
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.flagList = [[NSMutableArray alloc] init];
        self.remarkList = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

@end



@implementation DoctorFilter

@end

@implementation DoctorAppointmentListItem


@end

@implementation SelectOrderTime

@end

@implementation MyDoctorFilter

@end

