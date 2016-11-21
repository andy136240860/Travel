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
#import "XWTravelPublishManager.h"

@protocol XWTableViewDelegate <NSObject>

- (void) touchesMoved;

@end

@interface XWTableView : UITableView

@property (weak, nonatomic) id <XWTableViewDelegate> XWdelegate;

@end

@implementation XWTableView

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"touchesMoved....");
    if (self.XWdelegate) {
        [self.XWdelegate touchesMoved];
    }
}

@end


@interface TravelTogetherDetailVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,XWSegmentBarDelegate,XWTableViewDelegate> {
    BOOL touchedSegmentByUser;
}

@property (nonatomic, strong) XWTableView *contentTabelView;
@property (nonatomic, strong) TravelTogetherDetailHeaderView *tableHeaderView;
//@property (nonatomic, strong) 

@end

@implementation TravelTogetherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButtonWithTitle:@"发布" seletor:@selector(publish)];
    // Do any additional setup after loading the view.
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableHeaderViewFrameChangeAction) name:kNotification_TableHeaderViewFrameChange object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.contentTabelView.tableHeaderView = self.tableHeaderView;
}

- (void)loadContentView {
    _contentTabelView = [[XWTableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    _contentTabelView.delegate = self;
    _contentTabelView.tableFooterView = [UIView new];
    _contentTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTabelView.dataSource = self;
    _contentTabelView.XWdelegate = self;
    [self.contentView addSubview:_contentTabelView];
    _contentTabelView.tableHeaderView = self.tableHeaderView;
}

- (void)loadData {
    if (self.travelTogether) {
        self.tableHeaderView.travelTogether = self.travelTogether;
        self.contentTabelView.tableHeaderView = self.tableHeaderView;
    }
}

- (void)tableHeaderViewFrameChangeAction {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentTabelView.tableHeaderView = self.tableHeaderView;
    }];
}

- (TravelTogetherDetailHeaderView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[TravelTogetherDetailHeaderView alloc]init];
        _tableHeaderView.segmentBar.delegate = self;
    }
    CGFloat height = [_tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = _tableHeaderView.frame;
    frame.size.height = height;
    
    _tableHeaderView.frame = frame;
    
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
            NSLog(@"%f",scrollView.contentOffset.y);
            [_tableHeaderView.segmentBar removeFromSuperview];
            _tableHeaderView.segmentBar.frameY = [TravelDetailHeaderView defaultHeight];
            [_tableHeaderView addSubview:_tableHeaderView.segmentBar];
        }
    }
    
    if (touchedSegmentByUser) {
        return;
    }

    if (scrollView.contentOffset.y < (_tableHeaderView.travelTiTleAndDetailView.maxY - [XWSegmentBar defaultHeight] - 18)) {
        [_tableHeaderView.segmentBar selectSegmentIndex:0];
    }
    
    if (scrollView.contentOffset.y < (_tableHeaderView.travelMatesView.maxY - [XWSegmentBar defaultHeight] - 18) && scrollView.contentOffset.y > (_tableHeaderView.travelMatesView.frameY - [XWSegmentBar defaultHeight] - 18)) {
        [_tableHeaderView.segmentBar selectSegmentIndex:1];
    }
    
    if (scrollView.contentOffset.y < (_tableHeaderView.travelTextAndImageDetailWebView.maxY - [XWSegmentBar defaultHeight] - 18) && scrollView.contentOffset.y > (_tableHeaderView.travelTextAndImageDetailWebView.frameY - [XWSegmentBar defaultHeight] - 18)) {
        [_tableHeaderView.segmentBar selectSegmentIndex:2];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    touchedSegmentByUser = NO;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    touchedSegmentByUser = NO;
}

- (void)touchesMoved {
    touchedSegmentByUser = NO;
}

- (void)didSelectedTitleWithIndex:(NSInteger)index {
    touchedSegmentByUser = YES;
    switch (index) {
        case 0:
        {
            if (!(self.contentTabelView.contentOffset.y < (_tableHeaderView.travelTiTleAndDetailView.maxY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTabelView setContentOffset:CGPointMake(0, _tableHeaderView.travelTiTleAndDetailView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        case 1:
        {
            if (!(self.contentTabelView.contentOffset.y < (_tableHeaderView.travelMatesView.maxY - [XWSegmentBar defaultHeight] - 18) && self.contentTabelView.contentOffset.y > (_tableHeaderView.travelMatesView.frameY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTabelView setContentOffset:CGPointMake(0, _tableHeaderView.travelMatesView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        case 2:
        {
            if (!(self.contentTabelView.contentOffset.y < (_tableHeaderView.travelTextAndImageDetailWebView.maxY - [XWSegmentBar defaultHeight] - 18) && self.contentTabelView.contentOffset.y > (_tableHeaderView.travelTextAndImageDetailWebView.frameY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTabelView setContentOffset:CGPointMake(0, _tableHeaderView.travelTextAndImageDetailWebView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        default:
            break;
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
    
    [XWTravelPublishManager saveTravelTogetherPrivate:self.travelTogether withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [blockSelf showMessageWithTitle:@"保存成功" type:TSMessageNotificationTypeSuccess];
            [XWTravelPublishManager sendStatusToFollowersWithData:self.travelTogether context:@"测试一下" block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [blockSelf showMessageWithTitle:@"发布成功" type:TSMessageNotificationTypeSuccess];
                }
            }];
        }
        else {
            [blockSelf showMessageWithTitle:@"保存失败，请检查网络设置, 数据会在下次联网时保存" type:TSMessageNotificationTypeWarning];
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


