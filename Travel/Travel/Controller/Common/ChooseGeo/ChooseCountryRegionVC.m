//
//  ChooseCountryRegionVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2017/1/5.
//  Copyright © 2017年 li na. All rights reserved.
//

#import "ChooseCountryRegionVC.h"

@interface ChooseCountryRegionVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation ChooseCountryRegionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadContentView {
    _contentTableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [self.contentView addSubview:_contentTableView];   
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
