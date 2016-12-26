//
//  CUListViewController.h
//  CollegeUnion
//
//  Created by li na on 15/3/7.
//  Copyright (c) 2015年 li na. All rights reserved.
//

//#import "XWViewController.h"
#import "XWBaseListModel.h"
#import "SNRefreshControl.h"
#import "SNLoadMoreControl.h"
#import "UIViewController+NavBarTool.h"
#import "UIViewController+SNExtension.h"
#import "UIViewController+TSMessageHandler.h"

@interface XWListController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong,readonly) NSString * pageName;

- (instancetype)initWithPageName:(NSString *)pageName;

- (instancetype)initWithPageName:(NSString *)pageName listModel:(XWBaseListModel *)listModel;

- (void)triggerRefresh;
- (void)triggerLoadMore;

/**第一次进入页面loading**/
- (void)initalizeLoading;


@property (nonatomic,strong) XWBaseListModel * listModel;
@property (nonatomic,strong) UITableView * contentTableView;

@property (nonatomic,strong,readonly) UIView * contentView;
@property (nonatomic,assign,readwrite)BOOL hasFreshControl;
@property (nonatomic,assign,readwrite)BOOL hasLoadMoreControl;
@property (nonatomic,assign,readwrite)BOOL shouldFreshWhenComing;

@property (nonatomic,strong) SNRefreshControl * freshControl;
@property (nonatomic,strong) SNLoadMoreControl * loadMoreControl;

@property (nonatomic,strong) UIView *noMoreFooterView;
@property (nonatomic,strong) UIButton *scrollToTopButton;

@property (nonatomic,strong) UIView * emptyView;
@property (nonatomic,strong) UIView * errorView;

//@property (nonatomic,strong) NSMutableArray * heightOfCells;
@property (nonatomic,strong) NSMutableDictionary * heightDictOfCells;


- (void)loadNavigationBar;
- (void)loadContentView;
- (void)removeContentView;


- (void)setShouldFreshControl;
- (void)setShouldLoadMoreControl;
- (void)setShouldFreshWhenComing;


@end


@interface XWListController (listEmptyView)

/**集成后由子类实现**/
- (UIView *)listEmptyView;

@end

@interface XWListController (keybord)

-(void)setViewMovedUp:(CGFloat)movedUpOffSet;

@end

@interface XWListController (listErrorView)

/**集成后由子类实现**/
- (UIView *)listErrorView;

@end
