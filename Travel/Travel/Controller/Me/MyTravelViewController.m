//
//  MyTravelViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "MyTravelViewController.h"
#import "AVOSCloud.h"

@implementation MyTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVUser *user = [AVUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"TravelTogether"];
    
    [query whereKey:@"TravelTogetherCompanions" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
        }
    }];
    
}

@end
