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
#import "XWUser.h"
#import "UIViewController+Login.h"

#import "CUCommentCell.h"
#import "CommentSendView.h"
#import "TipHandler+HUD.h"
#import "XWCommentManager.h"

@interface TravelTogetherDetailVC () <UITableViewDelegate,UITableViewDataSource,XWSegmentBarDelegate> {
    BOOL touchedSegmentByUser;
}


@property (nonatomic, strong) TravelTogetherDetailHeaderView *tableHeaderView;

@property (nonatomic, strong) CommentSendView *commentSendView;
@property (nonatomic, strong) CUCommentCell *replyToCommentCell;
@property (nonatomic, strong) CUComment *replyToComment;
@property CGRect replyRect;
@property CGPoint replyContentOffset;

@end

@implementation TravelTogetherDetailVC
@dynamic listModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButtonWithTitle:@"发布" seletor:@selector(publish)];
    // Do any additional setup after loading the view.
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableHeaderViewFrameChangeAction) name:kNotification_TableHeaderViewFrameChange object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.contentTableView.tableHeaderView = self.tableHeaderView;
}

- (void)loadContentView {
    self.contentTableView.tableHeaderView = self.tableHeaderView;
}

- (void)loadData {
    if (self.travelTogether) {
        self.tableHeaderView.travelTogether = self.travelTogether;
        self.contentTableView.tableHeaderView = self.tableHeaderView;
    }
}

- (void)tableHeaderViewFrameChangeAction {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentTableView.tableHeaderView = self.tableHeaderView;
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
            if (!(self.contentTableView.contentOffset.y < (_tableHeaderView.travelTiTleAndDetailView.maxY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTableView setContentOffset:CGPointMake(0, _tableHeaderView.travelTiTleAndDetailView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        case 1:
        {
            if (!(self.contentTableView.contentOffset.y < (_tableHeaderView.travelMatesView.maxY - [XWSegmentBar defaultHeight] - 18) && self.contentTableView.contentOffset.y > (_tableHeaderView.travelMatesView.frameY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTableView setContentOffset:CGPointMake(0, _tableHeaderView.travelMatesView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        case 2:
        {
            if (!(self.contentTableView.contentOffset.y < (_tableHeaderView.travelTextAndImageDetailWebView.maxY - [XWSegmentBar defaultHeight] - 18) && self.contentTableView.contentOffset.y > (_tableHeaderView.travelTextAndImageDetailWebView.frameY - [XWSegmentBar defaultHeight] - 18))) {
                [self.contentTableView setContentOffset:CGPointMake(0, _tableHeaderView.travelTextAndImageDetailWebView.frameY - [XWSegmentBar defaultHeight] - 18) animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableView Delegate & DataSource

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentDisplayInfo *displayInfo = [self.listModel.displayInfos objectAtIndexSafely:indexPath.row];
    
    return displayInfo.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BeautyCommentCell";
    CUCommentCell *cell = (CUCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CUCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = (id)self;
        
        CGFloat padding = 10;
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kDefaultLineHeight)];
        topLine.backgroundColor = kLightLineColor;
        topLine.tag = 11;
        [cell.contentView addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, kScreenWidth - padding * 2, kDefaultLineHeight)];
        bottomLine.backgroundColor = kLightLineColor;
        bottomLine.tag = 12;
        [cell.contentView addSubview:bottomLine];
    }
    
    CUComment *comment = [self.listModel.items objectAtIndexSafely:indexPath.row];
    CommentDisplayInfo *displayInfo = [self.listModel.displayInfos objectAtIndexSafely:indexPath.row];
    
    [cell updateWithData:comment displayInfo:displayInfo];
    cell.replyBtn.hidden = NO;//[[CUUserManager sharedInstance].user isEqual:comment.user];
    
    UIView *topLine = [cell.contentView viewWithTag:11];
    UIView *bottomLine = [cell.contentView viewWithTag:12];
    if (indexPath.row == 0) {
        topLine.hidden = NO;
    }
    else {
        topLine.hidden = YES;
    }
    
    CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row == self.listModel.items.count - 1) {
        bottomLine.hidden = YES;
    }
    else {
        bottomLine.hidden = NO;
        bottomLine.frameY = cellHeight - kDefaultLineHeight;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CommentDisplayInfo *displayInfo = [self.listModel.displayInfos objectAtIndexSafely:indexPath.row];
    CUCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self didClickCommentCell:cell toReply:cell.data replyRect:displayInfo.contentRect];
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

#pragma mark - Comment

- (void)didClickCommentCell:(CUCommentCell *)cell toReply:(CUComment *)comment replyRect:(CGRect)replyRect
{
    //    if ([[CUUserManager sharedInstance].user isEqual:comment.user]) {
    //        return;
    //    }
    
    self.replyToCommentCell = cell;
    self.replyToComment = comment;
    self.replyRect = replyRect;
    [self showSendViewWithPlaceholder:[NSString stringWithFormat:@"回复%@：", comment.user.nickName]];
}

- (void)showSendViewWithPlaceholder:(NSString *)placeholder
{
    if (![[XWUser currentUser] isAuthenticated]) {
        [self loginAction];
        return;
    }
    
    if (self.commentSendView == nil) {
        self.commentSendView = [[CommentSendView alloc] init];
        self.commentSendView.delegate = (id)self;
    }
    
    self.commentSendView.placeholder = placeholder;
    [self.commentSendView show];
    
    __weak typeof(self) weakSelf = self;
    self.commentSendView.sendAction = ^(NSString *content) {
        [weakSelf sendCommentAction];
    };
    
    self.commentSendView.cancelAction = ^{
        weakSelf.replyToComment = nil;
        weakSelf.replyToCommentCell = nil;
        weakSelf.replyRect = CGRectZero;
        
        if (weakSelf.replyContentOffset.y) {
            [weakSelf.contentTableView setContentOffset:weakSelf.replyContentOffset animated:YES];
        }
        
        weakSelf.replyContentOffset = CGPointZero;
    };
}

- (void)commentSendViewDidShow:(CommentSendView *)sendView position:(CGFloat)position
{
    if (!CGRectIsEmpty(self.replyRect)) {
        CGRect rect = [self.view convertRect:self.replyRect fromView:self.replyToCommentCell];
        rect.size.height += 10;
        //NSLog(@"点中评论 %@", [NSValue valueWithCGRect:rect]);
        if (position < CGRectGetMaxY(rect)) {
            CGFloat delY = CGRectGetMaxY(rect) - position;
            CGPoint contentOffset = self.contentTableView.contentOffset;
            if (contentOffset.y + delY < self.contentTableView.contentSize.height) {
                [self.contentTableView setContentOffset:CGPointMake(contentOffset.x, contentOffset.y + delY) animated:YES];
            }
            
            self.replyContentOffset = contentOffset;
        }
    }
}

- (void)sendCommentAction
{
    NSString *commentText = self.commentSendView.currentText;
    NSString *newText = [commentText stringByReplacingOccurrencesOfString:@" " withString:@""];
    newText = [newText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (newText.length == 0) {
        [TipHandler showTipOnlyTextWithNsstring:@"请输入正确的内容"];
        return;
    }
    
    [self hideSendView];
    if (self.replyContentOffset.y) {
        [self.contentTableView setContentOffset:self.replyContentOffset animated:YES];
    }
    
    [self showProgressView];
    
    __weak typeof(self) weakSelf = self;
    [XWCommentManager sendCommentWithObject:self.travelTogether toComment:self.replyToComment content:commentText block:^(id request, SNServerAPIResultData *result) {
        [weakSelf hideProgressView];
        
        if (weakSelf.replyToComment == nil) {
            [weakSelf handleCommentResult:result];
        }
        else {
            [weakSelf handleReplyResult:result];
        }
    }];
}

- (void)handleCommentResult:(SNServerAPIResultData *)result
{
    CUComment *comment = result.parsedModelObject;
    if (!result.hasError && [comment isKindOfClass:[CUComment class]]) {
        [self showSuccessWithTitle:@"评论成功"];
        
        CommentDisplayInfo *info = [CUCommentCell displayWithData:comment];
        
        [self.listModel.displayInfos insertObject:info atIndex:0];
        [self.listModel.items insertObject:comment atIndex:0];
        
        //TODO:
        // 评论数+1
//        self.detail.commentCount += 1;
//        self.detailHeaderView.commentCount = self.detail.commentCount;
        
//        if (self.listModel.items.count == 1) {
//            // 从无到有需刷新，其他时候不刷新避免性能消耗
//            [self.detailHeaderView updateWithData:self.detail hasComment:self.listModel.items.count showComment:YES];
//        }
        
        [self.contentTableView reloadData];
        [self hideSendView];
        
        // 通知列表刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_CommentCountDidChange object:self.travelTogether];
    }
    else {
        [self showErrorWithTitle:@"评论失败"];
    }
}

- (void)handleReplyResult:(SNServerAPIResultData *)result
{
    CUComment *comment = result.parsedModelObject;
    if (!result.hasError && [comment isKindOfClass:[CUComment class]]) {
        [self showSuccessWithTitle:@"回复成功"];
        
        CUReply *reply = [[CUReply alloc] init];
        reply.content = comment.content;
        reply.commentTimeStamp = comment.commentTimeStamp;
        reply.commentId = comment.commentId;
        reply.user = comment.user;
        
        reply.toUser = self.replyToComment.user;
        [self.replyToCommentCell.data.replyArray addObjectSafely:reply];
        
        CommentDisplayInfo *info = [CUCommentCell displayWithData:self.replyToCommentCell.data];
        NSInteger index = [self.listModel.items indexOfObject:self.replyToCommentCell.data];
        if (index != NSNotFound) {
            [self.listModel.displayInfos replaceObjectAtIndex:index withObject:info];
            
            [self.contentTableView beginUpdates];
            [self.replyToCommentCell updateWithData:self.replyToCommentCell.data displayInfo:info];
            
            UIView *bottomLine = [self.replyToCommentCell.contentView viewWithTag:12];
            bottomLine.frameY = info.cellHeight - kDefaultLineHeight;
            
            [self.contentTableView endUpdates];
        }
        
        self.replyToComment = nil;
        self.replyToCommentCell = nil;
        self.replyRect = CGRectZero;
        self.replyContentOffset = CGPointZero;
        
        [self hideSendView];
    }
    else {
        [self showErrorWithTitle:@"回复失败"];
    }
}

- (void)hideSendView
{
    self.commentSendView.currentText = nil;
    [self.commentSendView resetView];
    [self.commentSendView hide];
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


