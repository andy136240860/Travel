//
//  TravelTogetherDetailVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/24.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTogetherDetailVC.h"
#import "AVOSCloud.h"
#import "TravelTogetherDetailHeaderView.h"
#import "TravelDetailHeaderView.h"

@interface TravelTogetherDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *contentTabelView;
@property (nonatomic, strong) TravelTogetherDetailHeaderView *tableHeaderView;
//@property (nonatomic, strong) 

@end

@implementation TravelTogetherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButtonWithTitle:@"发布" seletor:@selector(publish)];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)loadContentView {
    _contentTabelView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    _contentTabelView.delegate = self;
    _contentTabelView.tableFooterView = [UIView new];
    _contentTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTabelView.dataSource = self;
    [self.contentView addSubview:_contentTabelView];
    _contentTabelView.tableHeaderView = self.tableHeaderView;
}

- (void)loadData {
    if (self.travelTogether) {
        self.tableHeaderView.travelTogether = self.travelTogether;
    }
}

- (TravelTogetherDetailHeaderView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[TravelTogetherDetailHeaderView alloc]init];
    }
    return _tableHeaderView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > [TravelDetailHeaderView defaultHeight]) {
        if ([_tableHeaderView.subviews containsObject:_tableHeaderView.segmentBar]) {
            [_tableHeaderView.segmentBar removeFromSuperview];
            _tableHeaderView.segmentBar.frameY = 0;
            [self.contentView addSubview:_tableHeaderView.segmentBar];
        }
    }
    else{
        if ([self.contentView.subviews containsObject:_tableHeaderView.segmentBar]) {
            [_tableHeaderView.segmentBar removeFromSuperview];
            _tableHeaderView.segmentBar.frameY = [TravelDetailHeaderView defaultHeight];
            [_tableHeaderView addSubview:_tableHeaderView.segmentBar];
        }
    }
}

#pragma mark - tableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    cell.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                      saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                      brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                           alpha:1];
    return cell;
}

- (void)publish {
    __weak __block typeof(self) blockSelf = self;
    AVObject *object = [AVObject objectWithClassName:@"TravelTogether"];
    [object setObject:self.travelTogether.title forKey:@"title"];
    [object setObject:self.travelTogether.destinatin forKey:@"destinatin"];
    [object setObject:@(self.travelTogether.startTime) forKey:@"startTime"];
    [object setObject:@(self.travelTogether.endTime) forKey:@"endTime"];
    [object setObject:@(self.travelTogether.peopleNumber) forKey:@"peopleNumber"];
    [object setObject:@(self.travelTogether.peopleNumberCanExceed) forKey:@"peopleNumberCanExceed"];
    [object setObject:@(self.travelTogether.price) forKey:@"price"];
    [object setObject:self.travelTogether.priceType forKey:@"priceType"];
    [object setObject:self.travelTogether.traffic forKey:@"traffic"];
    [object setObject:self.travelTogether.language forKey:@"language"];
    [object setObject:self.travelTogether.detail forKey:@"detail"];
    
    AVUser *user = [AVUser currentUser];
    AVRelation *relationCompanions = [object relationForKey:@"TravelTogetherCompanions"];
    [relationCompanions addObject:user];
    AVRelation *relationGuides = [object relationForKey:@"TravelTogetherGuides"];
    [relationGuides addObject:user];

    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [blockSelf showMessageWithTitle:@"保存成功" type:TSMessageNotificationTypeSuccess];
        }
        else {
            [blockSelf showMessageWithTitle:@"保存失败，请检查网络设置, 数据会在下次联网时保存" type:TSMessageNotificationTypeWarning];
            [object saveEventually];
        }
    }];
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
