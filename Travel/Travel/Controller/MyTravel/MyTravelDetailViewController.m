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
#import "Travel.h"
#import "XWGeoTool.h"

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
    
    [self addRightButtonWithTitle:@"保存" seletor:@selector(rightButtonAction)];
    
    XWGeoTool *geoTool = [[XWGeoTool alloc]init];
    [geoTool parse];
}

- (void)rightButtonAction {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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


@end
