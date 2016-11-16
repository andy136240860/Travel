//
//  Travel.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/11.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "Travel.h"

@implementation Forward

- (id)copyWithZone:(nullable NSZone *)zone {
    Forward *forword = [[Forward alloc]init];
    forword.context = [self.context copy];
    return forword;
}

@end

@implementation TravelBaseData

@end

@implementation TravelPicture

@end

@implementation TravelVideo

@end

@implementation TravelTogether

@end
