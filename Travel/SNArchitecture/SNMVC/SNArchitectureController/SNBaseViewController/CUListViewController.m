//
//  CUListViewController.m
//  CollegeUnion
//
//  Created by li na on 15/3/7.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "CUListViewController.h"
#import "CUUIContant.h"
#import "TipHandler+HUD.h"
#import "UIColor+SNExtension.h"
#import "SNUISystemConstant.h"
#import "SNListEmptyView.h"
#import "UIImage+Color.h"
#import "CUUIContant.h"
//#import "UINavigationBar+Background.h"

#define kLoadMoreCellHeigth 55
#define kDefaultCellNormalHeight    44

@interface CUListViewController ()<SNListEmptyViewDelegate>

@property (nonatomic,strong) UIView * content;

@end

@implementation CUListViewController

- (void)setShouldFreshControl
{
    self.hasFreshControl = YES;
}
- (void)setShouldLoadMoreControl
{
    self.hasLoadMoreControl = YES;
}
- (void)setShouldFreshWhenComing
{
    self.shouldFreshWhenComing = YES;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setShouldFreshControl];
        [self setShouldLoadMoreControl];
        [self setShouldFreshWhenComing];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:UIColorFromHex(Color_Hex_NavBackground)] forBarMetrics:UIBarMetricsDefault];
    
    //[self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:UIColorFromHex(Color_Hex_NavShadow) size:CGSizeMake(kDefaultLintWidth,kDefaultLintWidth)]];
    
    // --------------------如果有nav则重新生成一个可视的view,跟loadContentView的顺序不可以改
    [self addContentView];

    if (self.listModel != nil)
    {
        [self loadTableView];
        if (self.hasLoadMoreControl)
        {
            [self loadLoadMoreControl];
            [self loadNoMoreFooterView];
        }
        if (self.hasFreshControl)
        {
            [self loadRefreshControl];
        }
        if (self.shouldFreshWhenComing)
        {
//            [self initalizeLoading];
            [self triggerRefresh];
        }
    }

    // --------------------子类执行以下方法
    [self loadNavigationBar];
    [self loadContentView];
}

- (void)removeContentView
{
    [self.content removeFromSuperview];
    self.content = nil;
}

- (void)addContentView
{
    self.content = [[UIView alloc] initWithFrame:self.view.bounds];
    self.content.frameHeight -= Height_NavigationBar;
    [self.view addSubview:self.content];
    self.content.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);
    if (self.hidesBottomBarWhenPushed)
    {
        self.content.frameHeight -= Height_Tabbar;
    }
}

- (UIView *)contentView
{
    if (self.content != nil)
    {
        return self.content;
    }
    return self.view;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.heightDictOfCells = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithPageName:(NSString *)pageName listModel:(SNBaseListModel *)listModel
{
    if (self = [self initWithPageName:pageName])
    {
        self.listModel = listModel;
    }
    return self;
}

- (instancetype)initWithPageName:(NSString *)pageName
{
    if (self = [self init])
    {
        _pageName = pageName;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contentTableView.scrollsToTop = YES;
    // TODO:为何总是设成YES？
    //self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.contentTableView.scrollsToTop = NO;
    //self.hidesBottomBarWhenPushed = NO;

//    ImgStr_BackBtn = @"navbar_back_button";
//    Color_Hex_NavText_Normal = Color_Hex_Text_Normal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNavigationBar
{
    // 去掉导航的阴影
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)removeFreshControl
{
    [self.freshControl removeFromSuperview];
    self.freshControl = nil;
}
- (void)removeLoadMoreControl
{
    self.contentTableView.tableFooterView = nil;
    self.loadMoreControl = nil;
}

- (void)loadContentView
{
    
}

- (void)loadRefreshControl
{
    //refresh header
    self.freshControl = [SNRefreshControl refreshControlWithAttachedView:self.contentTableView style:SNRefreshControlStyleArrow];
    self.freshControl.frame = CGRectOffset(self.freshControl.frame, 0, 0);
    self.freshControl.backgroundColor = [UIColor clearColor];
    [self.freshControl addTarget:self action:@selector(triggerRefresh) forControlEvents:UIControlEventValueChanged];
}
- (void)loadLoadMoreControl
{
    //load more
    self.loadMoreControl = [[SNLoadMoreControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kLoadMoreCellHeigth) attachedView:self.contentTableView];
    [self.loadMoreControl addTarget:self action:@selector(triggerLoadMore) forControlEvents:UIControlEventValueChanged];
    self.loadMoreControl.backgroundColor = [UIColor clearColor];
}

- (void)loadNoMoreFooterView
{
    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    noDataLabel.text = @"没有更多内容了";
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.textColor = kDarkGrayColor;
    noDataLabel.font = [UIFont systemFontOfSize:15];
    
    _noMoreFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, noDataLabel.frameHeight + 10)];
    _noMoreFooterView.backgroundColor = [UIColor clearColor];
    [_noMoreFooterView addSubview:noDataLabel];
}

- (void)loadTableView
{
    self.contentTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.contentTableView.backgroundColor = UIColorFromHex(Color_Hex_ContentViewBackground);;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.separatorColor = UIColorFromHex(Color_Hex_Tableview_Separator);
    self.contentTableView.rowHeight = kDefaultCellNormalHeight;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentView addSubview:self.contentTableView];
    
    self.contentTableView.separatorInset = UIEdgeInsetsZero;
    self.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 空页面
    self.emptyView = [self listEmptyView];
    self.emptyView.hidden = YES;
    [self.contentTableView addSubview:self.emptyView];
    self.emptyView.centerY = self.contentTableView.frameHeight/2.0;
    self.emptyView.centerX = self.contentTableView.frameWidth/2.0;
    
    // 空页面
    self.errorView = [self listErrorView];
    self.errorView.hidden = YES;
    [self.contentTableView addSubview:self.errorView];
    self.errorView.centerY = self.contentTableView.frameHeight/2.0;
    self.errorView.centerX = self.contentTableView.frameWidth/2.0;
    
    // 返回顶部button
    CGFloat btnSize = 40.0;
    CGFloat btnPadding = 15.0;
    self.scrollToTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scrollToTopButton.frame = CGRectMake(kScreenWidth - btnSize - btnPadding, self.contentView.frameHeight - btnSize - btnPadding, btnSize, btnSize);
    [self.scrollToTopButton setImage:[UIImage imageNamed:@"home_top_icon"] forState:UIControlStateNormal];
    self.scrollToTopButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.scrollToTopButton addTarget:self action:@selector(scrollsToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.contentTableView scrollsToTop];
    [self.contentView addSubview:self.scrollToTopButton];
    self.scrollToTopButton.hidden = YES;
}

- (void)emptyViewClicked
{
    self.emptyView.hidden = YES;
    self.errorView.hidden = YES;
    [self triggerRefresh];
}

//-----------------------------------------------------------------------------------------------------

- (void)initalizeLoading
{
    [self showProgressView];
    self.listModel.isLoading = YES;
    __weak __block CUListViewController * blockSelf = self;
    [self.listModel gotoFirstPage:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        
        blockSelf.listModel.isLoading = NO;
        [blockSelf hideProgressView];
        
        // 先隐藏，后判断显示
        blockSelf.errorView.hidden = YES;
        blockSelf.emptyView.hidden = YES;
        
        if (!result.hasError)
        {
            [blockSelf.freshControl refreshLastUpdatedTime:[NSDate date]];
            [blockSelf.contentTableView reloadData];
            // 添加空页面
            if ([blockSelf.listModel.items count] == 0)
            {
                blockSelf.emptyView.hidden = NO;
            }
            
            if ([blockSelf.listModel hasNext])
            {
                blockSelf.contentTableView.tableFooterView = blockSelf.loadMoreControl;
            }
            else
            {
                if (blockSelf.listModel.items.count && blockSelf.contentTableView.frameHeight < blockSelf.contentTableView.contentSize.height) {
                    blockSelf.contentTableView.tableFooterView = blockSelf.noMoreFooterView;
                }
                else {
                    blockSelf.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                }
            }
        }
        else
        {
            [TipHandler showHUDText:[result.error.userInfo valueForKey:NSLocalizedDescriptionKey] inView:blockSelf.view];
            
            // 添加错误页面
            if ([blockSelf.listModel.items count] == 0)
            {
                blockSelf.errorView.hidden = NO;
            }
        }
        
        if ([blockSelf.listModel.items count] == 0)
        {
            blockSelf.scrollToTopButton.hidden = YES;
        }
        else // 隐藏空页面
        {
            blockSelf.scrollToTopButton.hidden = NO;
        }
    }];
    
}

- (void)triggerRefresh
{
    [self.freshControl beginRefreshing];
    [self.loadMoreControl endLoading];
    self.listModel.isLoading = YES;
    __weak __block CUListViewController * blockSelf = self;
    [self.listModel gotoFirstPage:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        
        blockSelf.listModel.isLoading = NO;
        [blockSelf.freshControl endRefreshing];
        // 先隐藏，后判断显示
        blockSelf.errorView.hidden = YES;
        blockSelf.emptyView.hidden = YES;
        
        if (!result.hasError)
        {
            // height
            [blockSelf.heightDictOfCells removeAllObjects];
            
            [blockSelf.freshControl refreshLastUpdatedTime:[NSDate date]];
            [blockSelf.contentTableView reloadData];
            
            // 添加空页面
            if ([blockSelf.listModel.items count] == 0)
            {
                blockSelf.emptyView.hidden = NO;
            }
            
            // footer
            if ([blockSelf.listModel hasNext])
            {
                blockSelf.contentTableView.tableFooterView = blockSelf.loadMoreControl;
            }
            else
            {
                if (blockSelf.listModel.items.count && blockSelf.contentTableView.frameHeight < blockSelf.contentTableView.contentSize.height) {
                    blockSelf.contentTableView.tableFooterView = blockSelf.noMoreFooterView;
                }
                else {
                    blockSelf.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                }
            }
        }
        else
        {
            [TipHandler showHUDText:[result.error.userInfo valueForKey:NSLocalizedDescriptionKey] inView:blockSelf.view];

            // 添加错误页面
            if ([blockSelf.listModel.items count] == 0)
            {
                blockSelf.errorView.hidden = NO;
            }
        }
        
//        if ([blockSelf.listModel.items count] == 0)
//        {
//            blockSelf.scrollToTopButton.hidden = YES;
//        }
//        else
//        {
//            
//        }
        blockSelf.scrollToTopButton.hidden = NO;
    }];
}

- (void)triggerLoadMore
{
    [self.freshControl endRefreshing];
    self.listModel.isLoading = YES;
    [self.loadMoreControl beginLoading];
     __weak __block CUListViewController * blockSelf = self;
    [self.listModel gotoNextPage:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        
        blockSelf.listModel.isLoading = NO;
        [blockSelf.loadMoreControl endLoading];
        
        if (!result.hasError)
        {
            [blockSelf.contentTableView reloadData];
            if ([blockSelf.listModel hasNext])
            {
                blockSelf.contentTableView.tableFooterView = blockSelf.loadMoreControl;
            }
            else
            {
                blockSelf.contentTableView.tableFooterView = blockSelf.noMoreFooterView;
                //blockSelf.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            }
        }
        else
        {
            [TipHandler showHUDText:[result.error.userInfo valueForKey:NSLocalizedDescriptionKey] inView:blockSelf.view];

        }
    }];
}

- (void)dealloc
{
    self.contentTableView.delegate = nil;
    self.contentTableView.dataSource = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -mark ---------------UITableViewDataSource -------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listModel.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma -mark ---------------UITableViewDelegate -------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollsToTop
{
    [self.contentTableView setContentOffset:CGPointZero animated:YES];
}

@end


@implementation CUListViewController (listEmptyView)

/**集成后由子类实现**/
- (UIView *)listEmptyView
{
    SNListEmptyView * view = [[SNListEmptyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 244)];
    view.delegate = self;
    return view;
}

@end

@implementation CUListViewController (keybord)

-(void)setViewMovedUp:(CGFloat)movedUpOffSet
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.contentView.frame;
    
    rect.origin.y -= movedUpOffSet;
    rect.size.height += movedUpOffSet;
    self.contentView.frame = rect;
    [UIView commitAnimations];
}

@end

@implementation CUListViewController (listErrorView)

- (UIView *)listErrorView
{
    SNListEmptyView * view = [[SNListEmptyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 244)];
    view.type = SNListEmptyTypeDataError;
    view.delegate = self;
    return view;
}

@end
