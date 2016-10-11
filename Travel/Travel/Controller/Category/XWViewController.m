//
//  XWViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWViewController.h"

@interface XWViewController ()

@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadContentView];
    //[self Nav_useDefaultNavBarTitleColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}

- (void)loadContentView{

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
