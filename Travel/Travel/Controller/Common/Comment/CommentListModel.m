//
//  CommentListModel.m
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CommentListModel.h"
//#import "CommentManager.h"
#import "CUCommentCell.h"

static dispatch_queue_t get_comment_queue()
{
    static dispatch_queue_t comment_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (comment_queue == NULL) {
            comment_queue = dispatch_queue_create("com.hyc.huiyangche.comment_queue", DISPATCH_QUEUE_SERIAL);
        }
    });
    return comment_queue;
};

@implementation CommentListModel
//
//- (void)gotoFirstPage:(SNServerAPIResultBlock)resultBlock
//{
//    [[CommentManager sharedInstance] getCommentListWithBeauty:self.bueatyItem page:startPageNum pageSize:pageSize block:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result)
//     {
//         if (!result.hasError)
//         {
//             SNBaseListModel * list = result.parsedModelObject;
//             [self.items removeAllObjects];
//             [self.items addObjectsFromArray:list.items];
//             
//             SNPageInfo * info = list.pageInfo;
//             self.pageInfo.pageSize = info.pageSize;
//             self.pageInfo.totalPage = info.totalPage;
//             self.pageInfo.currentPage = startPageNum;
//             
//             dispatch_async(get_comment_queue(), ^{
//                 
//                 NSMutableArray *displayInfos = [NSMutableArray array];
//                 for (id data in list.items) {
//                     CommentDisplayInfo *displayInfo = [CUCommentCell displayWithData:data];
//                     [displayInfos addObjectSafely:displayInfo];
//                 }
//                 
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     [self.displayInfos removeAllObjects];
//                     self.displayInfos = [NSMutableArray arrayWithArray:displayInfos];
//                     
//                     resultBlock(request,result);
//                 });
//             });
//         }
//         else {
//             resultBlock(request,result);
//         }
//         
//     } pageName:@"BeautyCommentList"];
//}
//
//- (void)gotoNextPage:(SNServerAPIResultBlock)resultBlock
//{
//    [[CommentManager sharedInstance] getCommentListWithBeauty:self.bueatyItem page:self.pageInfo.currentPage + 1 pageSize:pageSize block:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result)
//     {
//         if (!result.hasError)
//         {
//             SNBaseListModel * list = result.parsedModelObject;
//             [self.items addObjectsFromArray:list.items];
//             
//             SNPageInfo * info = list.pageInfo;
//             self.pageInfo.pageSize = info.pageSize;
//             self.pageInfo.totalPage = info.totalPage;
//             self.pageInfo.currentPage++;
//             
//             dispatch_async(get_comment_queue(), ^{
//                 
//                 NSMutableArray *displayInfos = [NSMutableArray array];
//                 for (id data in list.items) {
//                     CommentDisplayInfo *displayInfo = [CUCommentCell displayWithData:data];
//                     [displayInfos addObjectSafely:displayInfo];
//                 }
//                 
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     [self.displayInfos addObjectsFromArray:displayInfos];
//                     
//                     resultBlock(request,result);
//                 });
//             });
//         }
//         else {
//             resultBlock(request,result);
//         }
//         
//     } pageName:@"BeautyCommentList"];
//}
//
//- (void)cancelRequest
//{
//    [[CommentManager sharedInstance] cancelCommentListRequest];
//}

@end
