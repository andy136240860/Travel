//
//  TravelTogetherDetailListModel.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/28.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTogetherDetailListModel.h"
#import "XWTravelPublishManager.h"
#import "XWCommentManager.h"
#import "CommentDisplayInfo.h"
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

@implementation TravelTogetherDetailListModel

- (void)gotoFirstPage:(XWServerAPIBlock)resultBlock
{
    [XWCommentManager getCommentListWithObject:self.travelTogether page:startPageNum pageSize:pageSize block:^(id request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            XWBaseListModel * list = result.parsedModelObject;
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:list.items];
            
            XWPageInfo * info = list.pageInfo;
            self.pageInfo.pageSize = info.pageSize;
            self.pageInfo.totalPage = info.totalPage;
            self.pageInfo.currentPage = startPageNum;
            
            dispatch_async(get_comment_queue(), ^{
                
                NSMutableArray *displayInfos = [NSMutableArray array];
                for (id data in list.items) {
                    CommentDisplayInfo *displayInfo = [CUCommentCell displayWithData:data];
                    [displayInfos addObjectSafely:displayInfo];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.displayInfos removeAllObjects];
                    self.displayInfos = [NSMutableArray arrayWithArray:displayInfos];
                    
                    resultBlock(request,result);
                });
            });
        }
        else {
            resultBlock(request,result);
        }

    } pageName:@"TravelTogetherDetailVC"];
}

- (void)gotoNextPage:(XWServerAPIBlock)resultBlock
{
    [XWCommentManager getCommentListWithObject:self.travelTogether page:startPageNum pageSize:pageSize block:^(id request, SNServerAPIResultData *result)
     {
         if (!result.hasError)
         {
             XWBaseListModel * list = result.parsedModelObject;
             [self.items addObjectsFromArray:list.items];
             
             XWPageInfo * info = list.pageInfo;
             self.pageInfo.pageSize = info.pageSize;
             self.pageInfo.totalPage = info.totalPage;
             self.pageInfo.currentPage++;
             
             dispatch_async(get_comment_queue(), ^{
                 
                 NSMutableArray *displayInfos = [NSMutableArray array];
                 for (id data in list.items) {
                     CommentDisplayInfo *displayInfo = [CUCommentCell displayWithData:data];
                     [displayInfos addObjectSafely:displayInfo];
                 }
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.displayInfos addObjectsFromArray:displayInfos];
                     
                     resultBlock(request,result);
                 });
             });
         }
         else {
             resultBlock(request,result);
         }
         
     } pageName:@"TravelTogetherDetailVC"];
}

- (void)cancelRequest
{
//    [[CommentManager sharedInstance] cancelCommentListRequest];
}

@end
