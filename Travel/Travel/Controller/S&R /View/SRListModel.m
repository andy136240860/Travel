//
//  SRListModel.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/22.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "SRListModel.h"
#import "AVObject.h"

@implementation SRListModel

- (void)gotoFirstPage:(XWServerAPIBlock)resultBlock
{
    [XWTravelPublishManager getALLStatuswithPage:startPageNum pageSize:pageSize minDataTimestamp:0 block:^(id request,SNServerAPIResultData * result) {
        if (!result.hasError) {
            XWBaseListModel * list = result.parsedModelObject;
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:list.items];
            
            XWPageInfo * info = list.pageInfo;
            self.pageInfo.pageSize = info.pageSize;
            self.pageInfo.totalPage = info.totalPage;
            self.pageInfo.currentPage = startPageNum;
            
            self.pageInfo.minDataTimestamp = MAXFLOAT;
            self.pageInfo.maxDataTimestamp = 0;
            for (AVObject *object in list.items) {
                NSTimeInterval objectTimestamp = [object.createdAt timeIntervalSince1970];
                self.pageInfo.minDataTimestamp = objectTimestamp < self.pageInfo.minDataTimestamp ?
                objectTimestamp : self.pageInfo.minDataTimestamp;
                self.pageInfo.maxDataTimestamp = objectTimestamp > self.pageInfo.minDataTimestamp ?
                objectTimestamp : self.pageInfo.maxDataTimestamp;
            }
        }
        resultBlock(request,result);
    }];
}

- (void)gotoNextPage:(XWServerAPIBlock)resultBlock
{
    [XWTravelPublishManager getALLStatuswithPage:startPageNum pageSize:pageSize minDataTimestamp:self.pageInfo.minDataTimestamp block:^(id request,SNServerAPIResultData * result) {
        if (!result.hasError) {
            XWBaseListModel * list = result.parsedModelObject;
            [self.items addObjectsFromArray:list.items];
            
            XWPageInfo * info = list.pageInfo;
            self.pageInfo.pageSize = info.pageSize;
            self.pageInfo.totalPage = info.totalPage;
            self.pageInfo.currentPage++;
            
            for (AVObject *object in list.items) {
                NSTimeInterval objectTimestamp = [object.createdAt timeIntervalSince1970];
                self.pageInfo.minDataTimestamp = objectTimestamp < self.pageInfo.minDataTimestamp ?
                objectTimestamp : self.pageInfo.minDataTimestamp;
                self.pageInfo.maxDataTimestamp = objectTimestamp > self.pageInfo.minDataTimestamp ?
                objectTimestamp : self.pageInfo.maxDataTimestamp;
            }
        }
        resultBlock(request,result);
    }];
}


@end
