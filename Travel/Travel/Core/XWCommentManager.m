//
//  XWCommentManager.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/25.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWCommentManager.h"
#import "AVQuery.h"
#import "XWBaseListModel.h"

@implementation XWCommentManager

// 发表评论或者回复
+ (void)sendCommentWithObject:(AVObject *)object toComment:(CUComment *)comment content:(NSString *)contentText block:(XWServerAPIBlock)block {
    XWUser *user = [XWUser currentUser];
    if ([user isAuthenticated]) {
        if (comment == nil) {
            XWComment *newComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class])];
            newComment.user = user;
            newComment.context = contentText;
            newComment.superData = object;
            newComment.infoId = newComment.objectId;
            [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                    resultData.hasError = NO;
                    resultData.parsedModelObject = newComment;
                    block(nil, resultData);
                }
                else {
                    SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                    resultData.hasError = YES;
                    resultData.error = [NSError errorWithDomain:@"网络错误" code:-1 userInfo:nil];
                    block(nil, resultData);
                }
            }];
        }
        else {
            XWComment *newComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class])];
            newComment.user = user;
            newComment.toUser = comment.user;
            newComment.context = contentText;
            newComment.superData = object;
            newComment.infoId = comment.infoId;
            [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    XWComment *baseComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class]) objectId:comment.infoId];
                    [baseComment.relayArr addObject:comment];
                    [baseComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        if (succeeded) {
                            SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                            resultData.hasError = NO;
                            resultData.parsedModelObject = newComment;
                            block(nil, resultData);
                        }
                        else {
                            SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                            resultData.hasError = YES;
                            resultData.error = [NSError errorWithDomain:@"网络错误" code:-1 userInfo:nil];
                            block(nil, resultData);
                        }
                    }];
                }
                else {
                    SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                    resultData.hasError = YES;
                    resultData.error = [NSError errorWithDomain:@"网络错误" code:-1 userInfo:nil];
                    block(nil, resultData);
                }
            }];
        }
    }
    else {
        SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
        resultData.hasError = YES;
        resultData.error = [NSError errorWithDomain:@"用户登陆过期" code:-1 userInfo:nil];
        block(nil, resultData);
    }
}

// 获取评论列表
+ (void)getCommentListWithObject:(AVObject *)object page:(NSInteger)page pageSize:(NSInteger)pageSize block:(XWServerAPIBlock)block pageName:(NSString *)pageName {
    AVQuery *commentQuery = [AVQuery queryWithClassName:NSStringFromClass([XWComment class])];
    [commentQuery orderByDescending:@"createdAt"];
    commentQuery.limit = pageSize;
    commentQuery.skip = page*pageSize;
    [commentQuery includeKey:@"relayArr"];// 关键代码，用 includeKey 告知云端需要返回的关联属性对应的对象的详细信息，而不仅仅是 objectId
    [commentQuery findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // comments 是最近的十条评论, 其 targetTodoFolder 字段也有相应数据
//        for (XWComment *comment in comments) {
//            // 并不需要网络访问
//            AVObject *todoFolder = [comment objectForKey:@"targetTodoFolder"];
//            AVUser *avUser = [todoFolder objectForKey:@"targetAVUser"];
        if (!error) {
            SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
            resultData.hasError = NO;
            XWBaseListModel *listModel = [[XWBaseListModel alloc]init];
            listModel.items = [NSMutableArray arrayWithArray:comments];
            resultData.parsedModelObject = listModel;
            block(nil, resultData);
        }
        else {
            SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
            resultData.hasError = YES;
            resultData.error = error;
            block(nil, resultData);
        }
        
    }];
}

@end
