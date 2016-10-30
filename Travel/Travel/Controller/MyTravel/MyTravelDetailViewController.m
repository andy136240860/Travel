//
//  MyTravelDetailViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "MyTravelDetailViewController.h"
#import "MyTravelDetailHeaderView.h"
#import "AVOSCloud.h"

@interface MyTravelDetailViewController () {

}

@property (nonatomic, strong) UITableView *contentTabelView;
@property (nonatomic, strong) MyTravelDetailHeaderView *tableHeaderView;
@end

@implementation MyTravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_prefersNavigationBarHidden = YES;
    self.title = @"我的旅行";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObjectSafely:@(0) forKey:@"typeid"];
//    [dic setObjectSafely:@(0) forKey:@"startnumber"];
//    [AVCloud callFunctionInBackground:@"Home" withParameters:dic block:^(id object, NSError *error) {
//        
//    }];
    AVObject *GuideService =[AVObject objectWithClassName:@"GuideService" objectId:@"57b554e8c4c971005f909151"];
    [GuideService fetchInBackgroundWithBlock:^(AVObject *avObject, NSError *error) {
        if (!error) {
            
        }
    }];
    
}

- (void)loadContentView {
    _contentTabelView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:_contentTabelView];
    _contentTabelView.tableHeaderView = self.tableHeaderView;
}

- (MyTravelDetailHeaderView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[MyTravelDetailHeaderView alloc]init];
    }
    return _tableHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
