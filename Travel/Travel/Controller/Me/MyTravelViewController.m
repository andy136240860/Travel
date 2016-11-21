//
//  MyTravelViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/5.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "MyTravelViewController.h"
#import "AVOSCloud.h"
#import "XWUser.h"

@implementation MyTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XWUser *user = [XWUser currentUser];
    
    AVQuery *query = [AVQuery queryWithClassName:@"TravelTogether"];
    
    [query whereKey:@"TravelTogetherCompanions" equalTo:user];
//    [query includeKey:@"TravelTogetherCompanions"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
        }
    }];
    
}

@end
