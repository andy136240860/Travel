//
//  HomeViewController.m
//  Demo
//
//  Created by 格式化油条 on 15/7/7.
//  Copyright (c) 2015年 格式化油条. All rights reserved.
//

#import "HomeViewController.h"
#import "XWHomeModel.h"
#import "XWHomeCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ChatKeyBoard.h"
#import "ZFPlayer.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,XWHomeCellDelegate,ChatKeyBoardDelegate,ChatKeyBoardDataSource>

/**
 *  解析json数据后得到的数据
 */
@property (strong, nonatomic) NSArray *feedsDataFormJSON;

/**
 *  用于给数据源使用的数组
 */
@property (strong, nonatomic) NSMutableArray *feeds;

@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, assign) BOOL needUpdateOffset;//控制是否刷新table的offset
@property (nonatomic, assign) CGFloat history_Y_offset;//记录table的offset.y
@property (nonatomic, assign) CGFloat seletedCellHeight;//记录点击cell的高度，高度由代理传过来
//专门用来回复选中的cell的model
@property (nonatomic, strong) CommentModel *replayTheSeletedCellModel;
@property (nonatomic,copy)NSIndexPath *currentIndexPath;

@property (nonatomic, strong) ZFPlayerView   *playerView;

@end

@implementation HomeViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //注册键盘出现NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        
        //注册键盘隐藏NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.navigationController.navigationBar.barTintColor = kAppStyleColor;
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    [self loadJSONData:^{ // 加载完josn数据后要做的操作
        
        self.feeds = @[].mutableCopy;
        
        [self.feeds addObject:self.feedsDataFormJSON.mutableCopy];
        
        // 给一个标识符，告诉tableView要创建哪个类
        [self.tableView registerClass:[XWHomeCell class] forCellReuseIdentifier:@"feedCell"];
        
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
            
            [feedArrayM addObject:[XWHomeModel feedWithDictionary:obj]];
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
    
    XWHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    cell.delegate = self;
    
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) setupModelOfCell:(XWHomeCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    __weak __typeof(self) weakSelf= self;
    __block NSIndexPath *weakIndexPath = indexPath;
    __block XWHomeCell *weakCell     = cell;
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
//    cell.fd_enforceFrameLayout = NO;
    
    cell.feed = self.feeds[indexPath.section][indexPath.row];
    __block XWHomeModel *model = [self.feedsDataFormJSON objectAtIndex:indexPath.row];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    __weak __typeof(window) weakWindow = window;
    cell.playBlock = ^(UIButton *btn){
        weakSelf.playerView = [ZFPlayerView sharedPlayerView];
        // 设置播放前的站位图（需要在设置视频URL之前设置）
//        weakSelf.playerView.placeholderImageName = @"loading_bgView1";
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
//        NSMutableDictionary *dic = @{}.mutableCopy;
//        for (ZFPlyerResolution * resolution in model.playInfo) {
//            [dic setValue:resolution.url forKey:resolution.name];
//        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:weakCell.feed.contentVideoURL];
        
        // 设置player相关参数(需要设置imageView的tag值，此处设置的为101)
//        [weakSelf.playerView ]
//        [weakSelf.playerView setVideoURL:videoURL
//                           withTableView:weakSelf.tableView
//                             AtIndexPath:weakIndexPath
//                        withImageViewTag:101];
//        [weakSelf.playerView addPlayerToCellImageView:weakCell.picView];
//        
        // 下载功能
        weakSelf.playerView.hasDownload   = YES;
        // 赋值分辨率字典
//        weakSelf.playerView.resolutionDic = dic;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        weakSelf.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 自动播放
        [weakSelf.playerView play];
    };
    
    //评论
    cell.CommentBtnClickBlock = ^(UIButton *commentBtn,NSIndexPath * indexPath)
    {
        
        //不是点击cell进行回复，则置空replayTheSeletedCellModel，因为这个时候是点击评论按钮进行评论，不是回复某某某
        self.replayTheSeletedCellModel = nil;
        weakSelf.seletedCellHeight = 0.0;
        weakSelf.needUpdateOffset = YES;
        weakSelf.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论 %@",model.username];
        weakSelf.history_Y_offset = [commentBtn convertRect:commentBtn.bounds toView:weakWindow].origin.y;
        weakSelf.currentIndexPath = indexPath;
        [weakSelf.chatKeyBoard keyboardUpforComment];
    };
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    return [self.tableView fd_heightForCellWithIdentifier:@"feedCell" cacheByIndexPath:indexPath configuration:^(XWHomeCell *cell) {
        // 在这个block中，重新cell配置数据源
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf= self;
    [weakSelf.chatKeyBoard keyboardDownForComment];
}

#pragma mark - passCellHeightWithModel

- (void)passCellHeightWithMessageModel:(XWHomeModel *)messageModel commentModel:(CommentModel *)commentModel atCommentIndexPath:(NSIndexPath *)commentIndexPath cellHeight:(CGFloat )cellHeight commentCell:(CommentCell *)commentCell messageCell:(XWHomeCell *)messageCell{
    self.needUpdateOffset = YES;
    self.replayTheSeletedCellModel = commentModel;
    self.currentIndexPath = [self.tableView indexPathForCell:messageCell];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复 %@",commentModel.commentUserName];
    self.history_Y_offset = [commentCell.contentLabel convertRect:commentCell.contentLabel.bounds toView:window].origin.y;
    self.seletedCellHeight = cellHeight;
    [self.chatKeyBoard keyboardUpforComment];
}
- (void)reloadCellHeightForModel:(XWHomeModel *)model atIndexPath:(NSIndexPath *)indexPath{
//    model.shouldUpdateCache = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark
#pragma mark keyboardWillShow
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    __block  CGFloat keyboardHeight = [aValue CGRectValue].size.height;
    if (keyboardHeight < 216) {//解决搜狗输入法三次调用此方法的bug、
        //        IOS8.0之后可以安装第三方键盘，如搜狗输入法之类的。
        //        获得的高度都为0.这是因为键盘弹出的方法:- (void)keyBoardWillShow:(NSNotification *)notification需要执行三次,你如果打印一下,你会发现键盘高度为:第一次:0;第二次:216:第三次:282.并不是获取不到高度,而是第三次才获取真正的高度.
        return;
    }
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat delta = 0.0;
    if (self.seletedCellHeight){//点击某行，进行回复某人
        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-self.seletedCellHeight-kChatToolBarHeight);
    }else{//点击评论按钮
        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-kChatToolBarHeight-24-10);//24为评论按钮高度，10为评论按钮上部的5加评论按钮下部的5
    }
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    if (self.needUpdateOffset) {
        [self.tableView setContentOffset:offset animated:YES];
    }
}

#pragma mark
#pragma mark keyboardWillHide
- (void)keyboardWillHide:(NSNotification *)notification {
    self.needUpdateOffset = NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"CommentViewController didReceiveMemoryWarning");
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.chatKeyBoard keyboardDownForComment];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"CommentViewController dealloc");
}

#pragma mark ChatKeyboard
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    //    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    //
    //    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    //
    //    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    return @[item1];
    
    //    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
//    return [FaceSourceManager loadFaceSource];
    return nil;
}

-(ChatKeyBoard *)chatKeyBoard{
    if (_chatKeyBoard==nil) {
        _chatKeyBoard =[ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.placeHolder = @"评论";
        [self.view addSubview:_chatKeyBoard];
        [self.view bringSubviewToFront:_chatKeyBoard];
    }
    return _chatKeyBoard;
}
- (void)chatKeyBoardSendText:(NSString *)text{
    XWHomeModel *messageModel = [self.feedsDataFormJSON objectAtIndex:self.currentIndexPath.row];
//    messageModel.shouldUpdateCache = YES;
    
    //创建一个新的CommentModel,并给相应的属性赋值，然后加到评论数组的最后，reloadData
    CommentModel *commentModel = [[CommentModel alloc]init];
    commentModel.commentUserName = @"文明";
    commentModel.commentUserId = @"274";
    commentModel.commentPhoto = @"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100";
    commentModel.commentByUserName = self.replayTheSeletedCellModel?self.replayTheSeletedCellModel.commentUserName:@"";
    commentModel.commentId = [NSString stringWithFormat:@"%i",(int)(100 + (arc4random() % (1000 - 100 + 1)))];
    commentModel.commentText = text;
    [messageModel.commentModelArray addObject:commentModel];
    
//    messageModel.shouldUpdateCache = YES;
    [self reloadCellHeightForModel:messageModel atIndexPath:self.currentIndexPath];
    [self.chatKeyBoard keyboardDownForComment];
    self.chatKeyBoard.placeHolder = nil;
}
- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceStyle:(NSInteger)faceStyle faceName:(NSString *)faceName delete:(BOOL)isDeleteKey{
    NSLog(@"%@",faceName);
}
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
    
}

@end
