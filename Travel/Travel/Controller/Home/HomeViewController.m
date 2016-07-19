//
//  HomeViewController.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "HomeViewController.h"
#import "XQFeedModel.h"
#import "XQFeedCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  解析json数据后得到的数据
 */
@property (strong, nonatomic) NSArray *feedsDataFormJSON;

/**
 *  用于给数据源使用的数组
 */
@property (strong, nonatomic) NSMutableArray *feeds;
@end

@implementation HomeViewController

- (instancetype)initWithPageName:(NSString *)pageName{
    self = [super initWithPageName:pageName];
    if (self) {
        self.hasNavigationBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    [self loadJSONData:^{ // 加载完josn数据后要做的操作
        
        self.feeds = @[].mutableCopy;
        
        [self.feeds addObject:self.feedsDataFormJSON.mutableCopy];
        
        // 给一个标识符，告诉tableView要创建哪个类
        [self.tableView registerClass:[XQFeedCell class] forCellReuseIdentifier:@"feedCell"];
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - 加载json数据
- (void) loadJSONData:(void(^)()) then {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *dataFilePath =[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        NSArray *feedArray = dataDictionary[@"feed"];
        
        NSMutableArray *feedArrayM = @[].mutableCopy;
        
        [feedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [feedArrayM addObject:[XQFeedModel feedWithDictionary:obj]];
        }];
        
        self.feedsDataFormJSON = feedArrayM;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !then ? : then();
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.feeds count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
    return [self.feeds[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XQFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) setupModelOfCell:(XQFeedCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
//    cell.fd_enforceFrameLayout = NO;
    
    cell.feed = self.feeds[indexPath.section][indexPath.row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.tableView fd_heightForCellWithIdentifier:@"feedCell" cacheByIndexPath:indexPath configuration:^(XQFeedCell *cell) {
        
        // 在这个block中，重新cell配置数据源
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

@end
